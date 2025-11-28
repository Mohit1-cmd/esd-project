import { useState, useEffect } from 'react';
import { domainsApi } from '../../api/domains';
import { specializationsApi } from '../../api/specializations';
import type { Domain, Specialization, DomainRequest, SpecializationRequest } from '../../types';
import LoadingSpinner from '../../components/common/LoadingSpinner';
import ErrorMessage from '../../components/common/ErrorMessage';
import './DomainsPage.css';

const DomainsPage = () => {
  const [domains, setDomains] = useState<Domain[]>([]);
  const [specializations, setSpecializations] = useState<Specialization[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [showDomainForm, setShowDomainForm] = useState(false);
  const [showSpecForm, setShowSpecForm] = useState(false);
  const [editingDomain, setEditingDomain] = useState<Domain | null>(null);
  const [editingSpec, setEditingSpec] = useState<Specialization | null>(null);

  const [domainForm, setDomainForm] = useState<DomainRequest>({
    domainName: '',
    description: '',
  });

  const [specForm, setSpecForm] = useState<SpecializationRequest>({
    domainId: 0,
    specializationName: '',
    description: '',
  });

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      setLoading(true);
      const [domainsData, specsData] = await Promise.all([
        domainsApi.getAll(),
        specializationsApi.getAll(),
      ]);
      setDomains(domainsData);
      setSpecializations(specsData);
      setError('');
    } catch (err) {
      setError('Failed to load data');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  // Domain handlers
  const handleCreateDomain = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await domainsApi.create(domainForm);
      await fetchData();
      setDomainForm({ domainName: '', description: '' });
      setShowDomainForm(false);
    } catch (err: any) {
      alert(err.response?.data?.error || 'Failed to create domain');
    }
  };

  const handleUpdateDomain = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!editingDomain) return;
    try {
      await domainsApi.update(editingDomain.domainId, domainForm);
      await fetchData();
      setEditingDomain(null);
      setDomainForm({ domainName: '', description: '' });
    } catch (err: any) {
      alert(err.response?.data?.error || 'Failed to update domain');
    }
  };

  const handleDeleteDomain = async (id: number) => {
    if (!window.confirm('Delete this domain? All associated specializations will be affected.')) return;
    try {
      await domainsApi.delete(id);
      await fetchData();
    } catch (err) {
      alert('Failed to delete domain');
    }
  };

  const startEditDomain = (domain: Domain) => {
    setEditingDomain(domain);
    setDomainForm({
      domainName: domain.domainName,
      description: domain.description || '',
    });
  };

  // Specialization handlers
  const handleCreateSpec = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await specializationsApi.create(specForm);
      await fetchData();
      setSpecForm({ domainId: 0, specializationName: '', description: '' });
      setShowSpecForm(false);
    } catch (err: any) {
      alert(err.response?.data?.error || 'Failed to create specialization');
    }
  };

  const handleUpdateSpec = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!editingSpec) return;
    try {
      await specializationsApi.update(editingSpec.specializationId, specForm);
      await fetchData();
      setEditingSpec(null);
      setSpecForm({ domainId: 0, specializationName: '', description: '' });
    } catch (err: any) {
      alert(err.response?.data?.error || 'Failed to update specialization');
    }
  };

  const handleDeleteSpec = async (id: number) => {
    if (!window.confirm('Delete this specialization?')) return;
    try {
      await specializationsApi.delete(id);
      await fetchData();
    } catch (err) {
      alert('Failed to delete specialization');
    }
  };

  const startEditSpec = (spec: Specialization) => {
    setEditingSpec(spec);
    setSpecForm({
      domainId: spec.specializationId, // Will need domain ID for update
      specializationName: spec.specializationName,
      description: spec.description || '',
    });
  };

  if (loading) return <LoadingSpinner />;
  if (error) return <ErrorMessage message={error} />;

  return (
    <div className="domains-page">
      <h1>Domains & Specializations Management</h1>

      <div className="sections-grid">
        {/* Domains Section */}
        <div className="section-card">
          <div className="section-header">
            <h2>Domains ({domains.length})</h2>
            <button onClick={() => setShowDomainForm(!showDomainForm)} className="btn btn-primary btn-sm">
              {showDomainForm ? 'Cancel' : '+ Add Domain'}
            </button>
          </div>

          {(showDomainForm || editingDomain) && (
            <form onSubmit={editingDomain ? handleUpdateDomain : handleCreateDomain} className="inline-form">
              <input
                type="text"
                placeholder="Domain Name"
                value={domainForm.domainName}
                onChange={(e) => setDomainForm({ ...domainForm, domainName: e.target.value })}
                required
                className="form-input"
              />
              <input
                type="text"
                placeholder="Description (optional)"
                value={domainForm.description}
                onChange={(e) => setDomainForm({ ...domainForm, description: e.target.value })}
                className="form-input"
              />
              <div className="form-buttons">
                <button type="submit" className="btn btn-success btn-sm">
                  {editingDomain ? 'Update' : 'Create'}
                </button>
                <button type="button" onClick={() => { setEditingDomain(null); setShowDomainForm(false); }} className="btn btn-secondary btn-sm">
                  Cancel
                </button>
              </div>
            </form>
          )}

          <div className="items-list">
            {domains.map((domain) => (
              <div key={domain.domainId} className="item-card">
                <div className="item-content">
                  <h3>{domain.domainName}</h3>
                  <p>{domain.description || 'No description'}</p>
                </div>
                <div className="item-actions">
                  <button onClick={() => startEditDomain(domain)} className="btn btn-sm btn-secondary">
                    Edit
                  </button>
                  <button onClick={() => handleDeleteDomain(domain.domainId)} className="btn btn-sm btn-danger">
                    Delete
                  </button>
                </div>
              </div>
            ))}
            {domains.length === 0 && <p className="no-items">No domains yet</p>}
          </div>
        </div>

        {/* Specializations Section */}
        <div className="section-card">
          <div className="section-header">
            <h2>Specializations ({specializations.length})</h2>
            <button onClick={() => setShowSpecForm(!showSpecForm)} className="btn btn-primary btn-sm">
              {showSpecForm ? 'Cancel' : '+ Add Specialization'}
            </button>
          </div>

          {(showSpecForm || editingSpec) && (
            <form onSubmit={editingSpec ? handleUpdateSpec : handleCreateSpec} className="inline-form">
              <select
                value={specForm.domainId}
                onChange={(e) => setSpecForm({ ...specForm, domainId: Number(e.target.value) })}
                required
                className="form-input"
              >
                <option value="">Select Domain</option>
                {domains.map((d) => (
                  <option key={d.domainId} value={d.domainId}>{d.domainName}</option>
                ))}
              </select>
              <input
                type="text"
                placeholder="Specialization Name"
                value={specForm.specializationName}
                onChange={(e) => setSpecForm({ ...specForm, specializationName: e.target.value })}
                required
                className="form-input"
              />
              <input
                type="text"
                placeholder="Description (optional)"
                value={specForm.description}
                onChange={(e) => setSpecForm({ ...specForm, description: e.target.value })}
                className="form-input"
              />
              <div className="form-buttons">
                <button type="submit" className="btn btn-success btn-sm">
                  {editingSpec ? 'Update' : 'Create'}
                </button>
                <button type="button" onClick={() => { setEditingSpec(null); setShowSpecForm(false); }} className="btn btn-secondary btn-sm">
                  Cancel
                </button>
              </div>
            </form>
          )}

          <div className="items-list">
            {specializations.map((spec) => (
              <div key={spec.specializationId} className="item-card">
                <div className="item-content">
                  <h3>{spec.specializationName}</h3>
                  <p>{spec.description || 'No description'}</p>
                </div>
                <div className="item-actions">
                  <button onClick={() => startEditSpec(spec)} className="btn btn-sm btn-secondary">
                    Edit
                  </button>
                  <button onClick={() => handleDeleteSpec(spec.specializationId)} className="btn btn-sm btn-danger">
                    Delete
                  </button>
                </div>
              </div>
            ))}
            {specializations.length === 0 && <p className="no-items">No specializations yet</p>}
          </div>
        </div>
      </div>
    </div>
  );
};

export default DomainsPage;
