import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import ProtectedRoute from './components/ProtectedRoute';
import Layout from './components/Layout/Layout';
import Home from './pages/Home';
import Login from './pages/Login';
import StudentsList from './pages/Students/StudentsList';
import StudentForm from './pages/Students/StudentForm';
import StudentDetail from './pages/Students/StudentDetail';
import CoursesList from './pages/Courses/CoursesList';
import CourseForm from './pages/Courses/CourseForm';
import CourseDetail from './pages/Courses/CourseDetail';
import AdminReports from './pages/Admin/AdminReports';

import './App.css';

function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Routes>
          <Route path="/login" element={<Login />} />
          
          <Route path="/" element={<ProtectedRoute><Layout /></ProtectedRoute>}>
            <Route index element={<Home />} />
            
            {/* Students Routes */}
            <Route path="students" element={<StudentsList />} />
            <Route path="students/new" element={<StudentForm />} />
            <Route path="students/:id" element={<StudentDetail />} />
            <Route path="students/:id/edit" element={<StudentForm />} />
            
            {/* Courses Routes */}
            <Route path="courses" element={<CoursesList />} />
            <Route path="courses/new" element={<CourseForm />} />
            <Route path="courses/:id" element={<CourseDetail />} />
            <Route path="courses/:id/edit" element={<CourseForm />} />
            
            {/* Domains & Specializations - Now showing Reports */}
            <Route path="domains" element={<AdminReports />} />
            
            {/* Admin Routes */}

          </Route>
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  );
}

export default App;
