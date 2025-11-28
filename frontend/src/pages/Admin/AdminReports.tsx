import { useState, useEffect } from 'react';
import { adminApi } from '../../api/admin';
import type { StudentSpecialization, Domain } from '../../types';
import LoadingSpinner from '../../components/common/LoadingSpinner';
import ErrorMessage from '../../components/common/ErrorMessage';
import './AdminReports.css';

const AdminReports = () => {
  const [specializations, setSpecializations] = useState<StudentSpecialization[]>([]);
  const [domains, setDomains] = useState<Domain[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [selectedDomain, setSelectedDomain] = useState('');

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      setLoading(true);
      const [specializationsData, domainsData] = await Promise.all([
        adminApi.getStudentSpecializations(),
        adminApi.getDomains(),
      ]);
      setSpecializations(specializationsData);
      setDomains(domainsData);
      setError('');
    } catch (err) {
      setError('Failed to load data');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleDomainFilter = async () => {
    try {
      setLoading(true);
      const data = selectedDomain
        ? await adminApi.getStudentSpecializations({ domain: selectedDomain })
        : await adminApi.getStudentSpecializations();
      setSpecializations(data);
      setError('');
    } catch (err) {
      setError('Failed to filter data');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!loading) {
      handleDomainFilter();
    }
  }, [selectedDomain]);

  if (loading && specializations.length === 0) return <LoadingSpinner />;
  if (error && specializations.length === 0) return <ErrorMessage message={error} />;

  return (
    <div className="admin-reports">
      <div className="page-header">
        <h1>Student Specializations Report</h1>
      </div>

      <div className="report-info">
        <p>Students who have earned specializations (more than 20 credits in a specialization)</p>
      </div>

      <div className="filters-section">
        <div className="filter-group">
          <label htmlFor="domainFilter">Filter by Domain:</label>
          <select
            id="domainFilter"
            value={selectedDomain}
            onChange={(e) => setSelectedDomain(e.target.value)}
            className="filter-select"
          >
            <option value="">All Domains</option>
            {domains.map((domain) => (
              <option key={domain.domainId} value={domain.domainName}>
                {domain.domainName}
              </option>
            ))}
          </select>
        </div>
      </div>

      <div className="stats-summary">
        <div className="summary-card">
          <div className="summary-icon">🎓</div>
          <div>
            <div className="summary-number">{specializations.length}</div>
            <div className="summary-label">Total Specializations Earned</div>
          </div>
        </div>
        <div className="summary-card">
          <div className="summary-icon">👨‍🎓</div>
          <div>
            <div className="summary-number">{new Set(specializations.map(s => s.studentId)).size}</div>
            <div className="summary-label">Students with Specializations</div>
          </div>
        </div>
      </div>

      <div className="table-container">
        {specializations.length > 0 ? (
          <table className="data-table">
            <thead>
              <tr>
                <th>Roll Number</th>
                <th>Student Name</th>
                <th>Email</th>
                <th>Specialization</th>
                <th>Domain</th>
                <th>Credits</th>
              </tr>
            </thead>
            <tbody>
              {specializations.map((spec, index) => (
                <tr key={index}>
                  <td>{spec.rollNumber}</td>
                  <td>{spec.firstName} {spec.lastName}</td>
                  <td>{spec.email}</td>
                  <td><strong>{spec.specializationName}</strong></td>
                  <td>
                    <span className="domain-badge">{spec.domainName}</span>
                  </td>
                  <td>
                    <span className="credits-badge">{spec.totalCredits} credits</span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        ) : (
          <div className="no-data">
            <div className="no-data-icon">📭</div>
            <h3>No specializations found</h3>
            <p>No students have earned specializations yet (requires more than 20 credits)</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default AdminReports;
