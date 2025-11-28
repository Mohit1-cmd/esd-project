import { Link } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { studentsApi } from '../api/students';
import { coursesApi } from '../api/courses';
import { domainsApi } from '../api/domains';
import './Home.css';

const Home = () => {
  const [stats, setStats] = useState({
    students: 0,
    courses: 0,
    domains: 0,
  });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const [students, courses, domains] = await Promise.all([
          studentsApi.getAll(),
          coursesApi.getAll(),
          domainsApi.getAll(),
        ]);
        setStats({
          students: students.length,
          courses: courses.length,
          domains: domains.length,
        });
      } catch (error) {
        console.error('Error fetching stats:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchStats();
  }, []);

  return (
    <div className="home">
      <div className="hero">
        <h1>Welcome to Student Specialization Management</h1>
        <p>Manage students, courses, enrollments, and track specializations</p>
      </div>

      {!loading && (
        <div className="stats-grid">
          <div className="stat-card">
            <div className="stat-icon">👨‍🎓</div>
            <div className="stat-number">{stats.students}</div>
            <div className="stat-label">Students</div>
          </div>
          <div className="stat-card">
            <div className="stat-icon">📚</div>
            <div className="stat-number">{stats.courses}</div>
            <div className="stat-label">Courses</div>
          </div>
          <div className="stat-card">
            <div className="stat-icon">🎯</div>
            <div className="stat-number">{stats.domains}</div>
            <div className="stat-label">Domains</div>
          </div>
        </div>
      )}

      <div className="quick-actions">
        <h2>Quick Actions</h2>
        <div className="action-grid">
          <Link to="/students" className="action-card">
            <div className="action-icon">👥</div>
            <h3>Manage Students</h3>
            <p>View, add, edit student records</p>
          </Link>
          <Link to="/courses" className="action-card">
            <div className="action-icon">📖</div>
            <h3>Manage Courses</h3>
            <p>View and manage course catalog</p>
          </Link>
          <Link to="/domains" className="action-card">
            <div className="action-icon">🌐</div>
            <h3>Domain Specialization</h3>
            <p>Manage academic domains and specializations</p>
          </Link>
        </div>
      </div>
    </div>
  );
};

export default Home;
