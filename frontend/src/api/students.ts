import { apiClient } from './client';
import type { Student, StudentRequest, Enrollment, StudentSpecialization } from '../types';

export const studentsApi = {
    // Get all students
    getAll: async (): Promise<Student[]> => {
        const response = await apiClient.get('/students');
        return response.data;
    },

    // Get student by ID
    getById: async (id: number): Promise<Student> => {
        const response = await apiClient.get(`/students/${id}`);
        return response.data;
    },

    // Get student by roll number
    getByRollNumber: async (rollNumber: string): Promise<Student> => {
        const response = await apiClient.get(`/students/roll/${rollNumber}`);
        return response.data;
    },

    // Create student
    create: async (data: StudentRequest): Promise<Student> => {
        const response = await apiClient.post('/students', data);
        return response.data;
    },

    // Update student
    update: async (id: number, data: StudentRequest): Promise<Student> => {
        const response = await apiClient.put(`/students/${id}`, data);
        return response.data;
    },

    // Delete student
    delete: async (id: number): Promise<void> => {
        await apiClient.delete(`/students/${id}`);
    },

    // Get student's courses
    getCourses: async (id: number): Promise<Enrollment[]> => {
        const response = await apiClient.get(`/students/${id}/courses`);
        return response.data;
    },

    // Get student's specializations
    getSpecializations: async (id: number): Promise<StudentSpecialization[]> => {
        const response = await apiClient.get(`/students/${id}/specializations`);
        return response.data;
    },
};
