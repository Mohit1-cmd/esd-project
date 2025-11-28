import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { coursesApi } from '../../api/courses';
import type { Course, Enrollment } from '../../types';
import LoadingSpinner from '../../components/common/LoadingSpinner';
import ErrorMessage from '../../components/common/ErrorMessage';
import '../Students/StudentDetail.css';

const CourseDetail = () => {
  const { id } = useParams();
  const [course, setCourse] = useState<Course | null>(null);
  const [students, setStudents] = useState<Enrollment[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    if (id) {
      fetchCourseData();
    }
  }, [id]);

  const fetchCourseData = async () => {
    try {
      setLoading(true);
      const [courseData, studentsData] = await Promise.all([
        coursesApi.getById(Number(id)),
        coursesApi.getStudents(Number(id)),
      ]);
      setCourse(courseData);
      setStudents(studentsData);
      setError('');
    } catch (err) {
      setError('Failed to load course details');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <LoadingSpinner />;
  if (error) return <ErrorMessage message={error} />;
  if (!course) return <ErrorMessage message="Course not found" />;

  return (
    <div className="student-detail">
      <div className="detail-header">
        <h1>{course.courseName}</h1>
        <div className="header-actions">
          <Link to={`/courses/${id}/edit`} className="btn btn-primary">
            Edit Course
          </Link>
          <Link to="/courses" className="btn btn-secondary">
            Back to List
          </Link>
        </div>
      </div>

      <div className="detail-grid">
        <div className="info-card">
          <h2>Course Information</h2>
          <div className="info-row">
            <span className="label">Course Code:</span>
            <span className="value"><strong>{course.courseCode}</strong></span>
          </div>
          <div className="info-row">
            <span className="label">Course Name:</span>
            <span className="value">{course.courseName}</span>
          </div>
          <div className="info-row">
            <span className="label">Credits:</span>
            <span className="value">{course.credits}</span>
          </div>
          <div className="info-row">
            <span className="label">Description:</span>
            <span className="value">{course.description || 'N/A'}</span>
          </div>
        </div>
      </div>

      <div className="info-card courses-card">
        <h2>Enrolled Students ({students.length})</h2>
        {students.length > 0 ? (
          <div className="courses-table-container">
            <table className="data-table-sm">
              <thead>
                <tr>
                  <th>Student Name</th>
                  <th>Academic Year</th>
                  <th>Semester</th>
                  <th>Grade</th>
                </tr>
              </thead>
              <tbody>
                {students.map((enrollment) => (
                  <tr key={enrollment.id}>
                    <td><strong>{enrollment.studentName}</strong></td>
                    <td>{enrollment.academicYear}</td>
                    <td>{enrollment.semester || 'N/A'}</td>
                    <td><span className="grade-badge">{enrollment.grade || 'N/A'}</span></td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ) : (
          <p className="no-data-text">No students enrolled</p>
        )}
      </div>
    </div>
  );
};

export default CourseDetail;
