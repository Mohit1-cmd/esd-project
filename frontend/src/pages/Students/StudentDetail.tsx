import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { studentsApi } from '../../api/students';
import type { Student, Enrollment, StudentSpecialization } from '../../types';
import LoadingSpinner from '../../components/common/LoadingSpinner';
import ErrorMessage from '../../components/common/ErrorMessage';
import './StudentDetail.css';

const StudentDetail = () => {
  const { id } = useParams();
  const [student, setStudent] = useState<Student | null>(null);
  const [courses, setCourses] = useState<Enrollment[]>([]);
  const [specializations, setSpecializations] = useState<StudentSpecialization[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    if (id) {
      fetchStudentData();
    }
  }, [id]);

  const fetchStudentData = async () => {
    try {
      setLoading(true);
      const [studentData, coursesData, specializationsData] = await Promise.all([
        studentsApi.getById(Number(id)),
        studentsApi.getCourses(Number(id)),
        studentsApi.getSpecializations(Number(id)),
      ]);
      setStudent(studentData);
      setCourses(coursesData);
      setSpecializations(specializationsData);
      setError('');
    } catch (err) {
      setError('Failed to load student details');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <LoadingSpinner />;
  if (error) return <ErrorMessage message={error} />;
  if (!student) return <ErrorMessage message="Student not found" />;

  return (
    <div className="student-detail">
      <div className="detail-header">
        <h1>{student.firstName} {student.lastName}</h1>
        <div className="header-actions">
          <Link to={`/students/${id}/edit`} className="btn btn-primary">
            Edit Student
          </Link>
          <Link to="/students" className="btn btn-secondary">
            Back to List
          </Link>
        </div>
      </div>

      <div className="detail-grid">
        <div className="info-card">
          <h2>Student Information</h2>
          <div className="info-row">
            <span className="label">Roll Number:</span>
            <span className="value">{student.rollNumber}</span>
          </div>
          <div className="info-row">
            <span className="label">Email:</span>
            <span className="value">{student.email}</span>
          </div>
          <div className="info-row">
            <span className="label">CGPA:</span>
            <span className="value">{student.cgpa?.toFixed(2) || 'N/A'}</span>
          </div>
          <div className="info-row">
            <span className="label">Total Credits:</span>
            <span className="value">{student.totalCredits || 0}</span>
          </div>
          <div className="info-row">
            <span className="label">Graduation Year:</span>
            <span className="value">{student.graduationYear || 'N/A'}</span>
          </div>
        </div>

        <div className="info-card">
          <h2>Specializations</h2>
          {specializations.length > 0 ? (
            <div className="spec-list">
              {specializations.map((spec) => (
                <div key={spec.specializationId} className="spec-item">
                  <div className="spec-header">
                    <strong>{spec.specializationName}</strong>
                    <span className="badge">{spec.totalCredits} credits</span>
                  </div>
                  <div className="spec-domain">{spec.domainName}</div>
                </div>
              ))}
            </div>
          ) : (
            <p className="no-data-text">No specializations earned yet (requires more than 20 credits)</p>
          )}
        </div>
      </div>

      <div className="info-card courses-card">
        <h2>Enrolled Courses ({courses.length})</h2>
        {courses.length > 0 ? (
          <div className="courses-table-container">
            <table className="data-table-sm">
              <thead>
                <tr>
                  <th>Course Code</th>
                  <th>Course Name</th>
                  <th>Academic Year</th>
                  <th>Semester</th>
                  <th>Grade</th>
                </tr>
              </thead>
              <tbody>
                {courses.map((enrollment) => (
                  <tr key={enrollment.id}>
                    <td>{enrollment.courseCode}</td>
                    <td>{enrollment.courseName}</td>
                    <td>{enrollment.academicYear}</td>
                    <td>{enrollment.semester || 'N/A'}</td>
                    <td><span className="grade-badge">{enrollment.grade || 'N/A'}</span></td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ) : (
          <p className="no-data-text">No courses enrolled</p>
        )}
      </div>
    </div>
  );
};

export default StudentDetail;
