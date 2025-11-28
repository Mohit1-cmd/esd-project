import { apiClient } from './client';
import type { Enrollment, EnrollmentRequest } from '../types';

export const enrollmentsApi = {
    // Get all enrollments
    getAll: async (): Promise<Enrollment[]> => {
        const response = await apiClient.get('/enrollments');
        return response.data;
    },

    // Get enrollment by ID
    getById: async (id: number): Promise<Enrollment> => {
        const response = await apiClient.get(`/enrollments/${id}`);
        return response.data;
    },

    // Get student enrollments
    getByStudent: async (studentId: number): Promise<Enrollment[]> => {
        const response = await apiClient.get(`/enrollments/student/${studentId}`);
        return response.data;
    },

    // Get course enrollments
    getByCourse: async (courseId: number): Promise<Enrollment[]> => {
        const response = await apiClient.get(`/enrollments/course/${courseId}`);
        return response.data;
    },

    // Create enrollment
    create: async (data: EnrollmentRequest): Promise<Enrollment> => {
        const response = await apiClient.post('/enrollments', data);
        return response.data;
    },

    // Update grade
    updateGrade: async (id: number, grade: string): Promise<Enrollment> => {
        const response = await apiClient.put(`/enrollments/${id}/grade`, { grade });
        return response.data;
    },

    // Drop course (delete enrollment)
    delete: async (id: number): Promise<void> => {
        await apiClient.delete(`/enrollments/${id}`);
    },
};
