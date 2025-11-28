import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { studentsApi } from '../../api/students';
import type { Student } from '../../types';
import LoadingSpinner from '../../components/common/LoadingSpinner';
import ErrorMessage from '../../components/common/ErrorMessage';
import './StudentsList.css';

const StudentsList = () => {
  const [students, setStudents] = useState<Student[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [searchTerm, setSearchTerm] = useState('');

  useEffect(() => {
    fetchStudents();
  }, []);

  const fetchStudents = async () => {
    try {
      setLoading(true);
      const data = await studentsApi.getAll();
      setStudents(data);
      setError('');
    } catch (err) {
      setError('Failed to load students');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id: number) => {
    if (!window.confirm('Are you sure you want to delete this student?')) return;

    try {
      await studentsApi.delete(id);
      setStudents(students.filter(s => s.studentId !== id));
    } catch (err) {
      alert('Failed to delete student');
      console.error(err);
    }
  };

  const filteredStudents = students.filter(s =>
    s.firstName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.lastName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.rollNumber.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.email.toLowerCase().includes(searchTerm.toLowerCase())
  );

  if (loading) return <LoadingSpinner />;
  if (error) return <ErrorMessage message={error} />;

  return (
    <div className="students-list">
      <div className="page-header">
        <h1>Students</h1>
        <Link to="/students/new" className="btn btn-primary">
          + Add New Student
        </Link>
      </div>

      <div className="search-bar">
        <input
          type="text"
          placeholder="Search by name, roll number, or email..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className="search-input"
        />
      </div>

      <div className="table-container">
        <table className="data-table">
          <thead>
            <tr>
              <th>Roll Number</th>
              <th>Name</th>
              <th>Email</th>
              <th>CGPA</th>
              <th>Credits</th>
              <th>Graduation Year</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {filteredStudents.map((student) => (
              <tr key={student.studentId}>
                <td>{student.rollNumber}</td>
                <td>{student.firstName} {student.lastName}</td>
                <td>{student.email}</td>
                <td>{student.cgpa?.toFixed(2) || 'N/A'}</td>
                <td>{student.totalCredits || 0}</td>
                <td>{student.graduationYear || 'N/A'}</td>
                <td className="actions">
                  <Link to={`/students/${student.studentId}`} className="btn btn-sm btn-info">
                    View
                  </Link>
                  <Link to={`/students/${student.studentId}/edit`} className="btn btn-sm btn-secondary">
                    Edit
                  </Link>
                  <button onClick={() => handleDelete(student.studentId)} className="btn btn-sm btn-danger">
                    Delete
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {filteredStudents.length === 0 && (
          <div className="no-data">No students found</div>
        )}
      </div>
    </div>
  );
};

export default StudentsList;
