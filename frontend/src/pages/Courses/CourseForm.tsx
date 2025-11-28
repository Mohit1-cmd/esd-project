import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { coursesApi } from '../../api/courses';
import type { CourseRequest } from '../../types';
import '../Students/StudentForm.css';

const CourseForm = () => {
  const navigate = useNavigate();
  const { id } = useParams();
  const isEdit = !!id;

  const [formData, setFormData] = useState<CourseRequest>({
    courseCode: '',
    courseName: '',
    description: '',
    credits: 4,
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (isEdit && id) {
      fetchCourse();
    }
  }, [id, isEdit]);

  const fetchCourse = async () => {
    try {
      const course = await coursesApi.getById(Number(id));
      setFormData({
        courseCode: course.courseCode,
        courseName: course.courseName,
        description: course.description || '',
        credits: course.credits,
      });
    } catch (err) {
      setError('Failed to load course');
      console.error(err);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      if (isEdit && id) {
        await coursesApi.update(Number(id), formData);
      } else {
        await coursesApi.create(formData);
      }
      navigate('/courses');
    } catch (err: any) {
      setError(err.response?.data?.error || 'Failed to save course');
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: name === 'credits' ? Number(value) : value
    }));
  };

  return (
    <div className="student-form-page">
      <div className="form-header">
        <h1>{isEdit ? 'Edit Course' : 'Add New Course'}</h1>
      </div>

      <div className="form-card">
        {error && <div className="alert alert-error">{error}</div>}

        <form onSubmit={handleSubmit}>
          <div className="form-grid">
            <div className="form-group">
              <label htmlFor="courseCode">Course Code *</label>
              <input
                type="text"
                id="courseCode"
                name="courseCode"
                value={formData.courseCode}
                onChange={handleChange}
                required
                className="form-control"
                placeholder="e.g., CS101"
              />
            </div>

            <div className="form-group">
              <label htmlFor="credits">Credits *</label>
              <input
                type="number"
                id="credits"
                name="credits"
                value={formData.credits}
                onChange={handleChange}
                required
                min="1"
                max="10"
                className="form-control"
              />
            </div>

            <div className="form-group" style={{ gridColumn: '1 / -1' }}>
              <label htmlFor="courseName">Course Name *</label>
              <input
                type="text"
                id="courseName"
                name="courseName"
                value={formData.courseName}
                onChange={handleChange}
                required
                className="form-control"
                placeholder="e.g., Introduction to Programming"
              />
            </div>

            <div className="form-group" style={{ gridColumn: '1 / -1' }}>
              <label htmlFor="description">Description</label>
              <textarea
                id="description"
                name="description"
                value={formData.description}
                onChange={handleChange}
                className="form-control"
                rows={3}
                placeholder="Course description (optional)"
              />
            </div>
          </div>

          <div className="form-actions">
            <button type="button" onClick={() => navigate('/courses')} className="btn btn-secondary">
              Cancel
            </button>
            <button type="submit" disabled={loading} className="btn btn-primary">
              {loading ? 'Saving...' : isEdit ? 'Update Course' : 'Create Course'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default CourseForm;
