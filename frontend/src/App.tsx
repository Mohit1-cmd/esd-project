import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Layout from './components/Layout/Layout';
import Home from './pages/Home';
import StudentsList from './pages/Students/StudentsList';
import StudentForm from './pages/Students/StudentForm';
import StudentDetail from './pages/Students/StudentDetail';
import AdminReports from './pages/Admin/AdminReports';
import './App.css';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Home />} />
          
          {/* Students Routes */}
          <Route path="students" element={<StudentsList />} />
          <Route path="students/new" element={<StudentForm />} />
          <Route path="students/:id" element={<StudentDetail />} />
          <Route path="students/:id/edit" element={<StudentForm />} />
          
          {/* Admin Routes */}
          <Route path="admin/reports" element={<AdminReports />} />
          
          {/* Placeholder routes for future pages */}
          <Route path="courses" element={<div className="page-placeholder"><h1>Courses</h1><p>Coming soon...</p></div>} />
          <Route path="enrollments" element={<div className="page-placeholder"><h1>Enrollments</h1><p>Coming soon...</p></div>} />
          <Route path="domains" element={<div className="page-placeholder"><h1>Domains & Specializations</h1><p>Coming soon...</p></div>} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
