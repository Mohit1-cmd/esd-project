import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { studentsApi } from '../../api/students';
import type { StudentRequest } from '../../types';
import './StudentForm.css';

const StudentForm = () => {
  const navigate = useNavigate();
  const { id } = useParams();
  const isEdit = !!id;

  const [formData, setFormData] = useState<StudentRequest>({
    rollNumber: '',
    firstName: '',
    lastName: '',
    email: '',
    cgpa: undefined,
    totalCredits: undefined,
    graduationYear: undefined,
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (isEdit && id) {
      fetchStudent();
    }
  }, [id, isEdit]);

  const fetchStudent = async () => {
    try {
      const student = await studentsApi.getById(Number(id));
      setFormData({
        rollNumber: student.rollNumber,
        firstName: student.firstName,
        lastName: student.lastName,
        email: student.email,
        cgpa: student.cgpa,
        totalCredits: student.totalCredits,
        graduationYear: student.graduationYear,
      });
    } catch (err) {
      setError('Failed to load student');
      console.error(err);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      if (isEdit && id) {
        await studentsApi.update(Number(id), formData);
      } else {
        await studentsApi.create(formData);
      }
      navigate('/students');
    } catch (err: any) {
      setError(err.response?.data?.error || 'Failed to save student');
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: name === 'cgpa' || name === 'totalCredits' || name === 'graduationYear'
        ? value === '' ? undefined : Number(value)
        : value
    }));
  };

  return (
    <div className="student-form-page">
      <div className="form-header">
        <h1>{isEdit ? 'Edit Student' : 'Add New Student'}</h1>
      </div>

      <div className="form-card">
        {error && <div className="alert alert-error">{error}</div>}

        <form onSubmit={handleSubmit}>
          <div className="form-grid">
            <div className="form-group">
              <label htmlFor="rollNumber">Roll Number *</label>
              <input
                type="text"
                id="rollNumber"
                name="rollNumber"
                value={formData.rollNumber}
                onChange={handleChange}
                required
                className="form-control"
              />
            </div>

            <div className="form-group">
              <label htmlFor="email">Email *</label>
              <input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                required
                className="form-control"
              />
            </div>

            <div className="form-group">
              <label htmlFor="firstName">First Name *</label>
              <input
                type="text"
                id="firstName"
                name="firstName"
                value={formData.firstName}
                onChange={handleChange}
                required
                className="form-control"
              />
            </div>

            <div className="form-group">
              <label htmlFor="lastName">Last Name *</label>
              <input
                type="text"
                id="lastName"
                name="lastName"
                value={formData.lastName}
                onChange={handleChange}
                required
                className="form-control"
              />
            </div>

            <div className="form-group">
              <label htmlFor="cgpa">CGPA</label>
              <input
                type="number"
                id="cgpa"
                name="cgpa"
                value={formData.cgpa || ''}
                onChange={handleChange}
                min="0"
                max="4"
                step="0.01"
                className="form-control"
              />
            </div>

            <div className="form-group">
              <label htmlFor="totalCredits">Total Credits</label>
              <input
                type="number"
                id="totalCredits"
                name="totalCredits"
                value={formData.totalCredits || ''}
                onChange={handleChange}
                min="0"
                className="form-control"
              />
            </div>

            <div className="form-group">
              <label htmlFor="graduationYear">Graduation Year</label>
              <input
                type="number"
                id="graduationYear"
                name="graduationYear"
                value={formData.graduationYear || ''}
                onChange={handleChange}
                min="2020"
                max="2030"
                className="form-control"
              />
            </div>
          </div>

          <div className="form-actions">
            <button type="button" onClick={() => navigate('/students')} className="btn btn-secondary">
              Cancel
            </button>
            <button type="submit" disabled={loading} className="btn btn-primary">
              {loading ? 'Saving...' : isEdit ? 'Update Student' : 'Create Student'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default StudentForm;
