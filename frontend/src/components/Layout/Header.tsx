import { Link, useLocation } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import './Header.css';

const Header = () => {
  const location = useLocation();
  const { user, logout } = useAuth();

  const isActive = (path: string) => {
    return location.pathname === path || location.pathname.startsWith(path + '/');
  };

  return (
    <header className="header">
      <div className="header-container">
        <Link to="/" className="logo">
          <h1>Student Specialization System</h1>
        </Link>
        <nav className="nav">
          <Link to="/" className={isActive('/') && location.pathname === '/' ? 'nav-link active' : 'nav-link'}>
            Home
          </Link>
          <Link to="/students" className={isActive('/students') ? 'nav-link active' : 'nav-link'}>
            Students
          </Link>
          <Link to="/courses" className={isActive('/courses') ? 'nav-link active' : 'nav-link'}>
            Courses
          </Link>
          <Link to="/domains" className={isActive('/domains') ? 'nav-link active' : 'nav-link'}>
            Domain Specialization
          </Link>
        </nav>
        {user && (
          <div className="user-section">
            <div className="user-info">
              {user.picture && <img src={user.picture} alt={user.name} className="user-avatar" />}
              <span className="user-name">{user.name}</span>
            </div>
            <button onClick={logout} className="logout-btn">
              Logout
            </button>
          </div>
        )}
      </div>
    </header>
  );
};

export default Header;
