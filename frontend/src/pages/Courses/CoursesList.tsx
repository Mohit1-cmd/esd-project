import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { coursesApi } from '../../api/courses';
import type { Course } from '../../types';
import LoadingSpinner from '../../components/common/LoadingSpinner';
import ErrorMessage from '../../components/common/ErrorMessage';
import './CoursesList.css';

const CoursesList = () => {
  const [courses, setCourses] = useState<Course[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [searchTerm, setSearchTerm] = useState('');

  useEffect(() => {
    fetchCourses();
  }, []);

  const fetchCourses = async () => {
    try {
      setLoading(true);
      const data = await coursesApi.getAll();
      setCourses(data);
      setError('');
    } catch (err) {
      setError('Failed to load courses');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id: number) => {
    if (!window.confirm('Are you sure you want to delete this course?')) return;

    try {
      await coursesApi.delete(id);
      setCourses(courses.filter(c => c.courseId !== id));
    } catch (err) {
      alert('Failed to delete course');
      console.error(err);
    }
  };

  const filteredCourses = courses.filter(c =>
    c.courseCode.toLowerCase().includes(searchTerm.toLowerCase()) ||
    c.courseName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    c.description?.toLowerCase().includes(searchTerm.toLowerCase())
  );

  if (loading) return <LoadingSpinner />;
  if (error) return <ErrorMessage message={error} />;

  return (
    <div className="courses-list">
      <div className="page-header">
        <h1>Courses</h1>
        <Link to="/courses/new" className="btn btn-primary">
          + Add New Course
        </Link>
      </div>

      <div className="search-bar">
        <input
          type="text"
          placeholder="Search by code, name, or description..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="search-input"
        />
      </div>

      <div className="table-container">
        <table className="data-table">
          <thead>
            <tr>
              <th>Course Code</th>
              <th>Course Name</th>
              <th>Description</th>
              <th>Credits</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {filteredCourses.map((course) => (
              <tr key={course.courseId}>
                <td><strong>{course.courseCode}</strong></td>
                <td>{course.courseName}</td>
                <td>{course.description || 'N/A'}</td>
                <td>{course.credits}</td>
                <td className="actions">
                  <Link to={`/courses/${course.courseId}`} className="btn btn-sm btn-info">
                    View
                  </Link>
                  <Link to={`/courses/${course.courseId}/edit`} className="btn btn-sm btn-secondary">
                    Edit
                  </Link>
                  <button onClick={() => handleDelete(course.courseId)} className="btn btn-sm btn-danger">
                    Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {filteredCourses.length === 0 && (
          <div className="no-data">No courses found</div>
        )}
      </div>
    </div>
  );
};

export default CoursesList;
