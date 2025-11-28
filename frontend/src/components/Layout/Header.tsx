import { Link, useLocation } from 'react-router-dom';
import './Header.css';

const Header = () => {
  const location = useLocation();

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
          <Link to="/enrollments" className={isActive('/enrollments') ? 'nav-link active' : 'nav-link'}>
            Enrollments
          </Link>
          <Link to="/domains" className={isActive('/domains') ? 'nav-link active' : 'nav-link'}>
            Domains
          </Link>
          <Link to="/admin/reports" className={isActive('/admin') ? 'nav-link active' : 'nav-link'}>
            Reports
          </Link>
        </nav>
      </div>
    </header>
  );
};

export default Header;
