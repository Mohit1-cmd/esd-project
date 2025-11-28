import { apiClient } from './client';
import type { Course, CourseRequest, Enrollment, CourseSpecialization, CourseSpecializationRequest } from '../types';

export const coursesApi = {
    // Get all courses
    getAll: async (): Promise<Course[]> => {
        const response = await apiClient.get('/courses');
        return response.data;
    },

    // Get course by ID
    getById: async (id: number): Promise<Course> => {
        const response = await apiClient.get(`/courses/${id}`);
        return response.data;
    },

    // Get course by code
    getByCode: async (code: string): Promise<Course> => {
        const response = await apiClient.get(`/courses/code/${code}`);
        return response.data;
    },

    // Create course
    create: async (data: CourseRequest): Promise<Course> => {
        const response = await apiClient.post('/courses', data);
        return response.data;
    },

    // Update course
    update: async (id: number, data: CourseRequest): Promise<Course> => {
        const response = await apiClient.put(`/courses/${id}`, data);
        return response.data;
    },

    // Delete course
    delete: async (id: number): Promise<void> => {
        await apiClient.delete(`/courses/${id}`);
    },

    // Get course students
    getStudents: async (id: number): Promise<Enrollment[]> => {
        const response = await apiClient.get(`/courses/${id}/students`);
        return response.data;
    },

    // Get course specializations
    getSpecializations: async (id: number): Promise<CourseSpecialization[]> => {
        const response = await apiClient.get(`/courses/${id}/specializations`);
        return response.data;
    },

    // Map course to specialization
    mapToSpecialization: async (id: number, data: CourseSpecializationRequest): Promise<CourseSpecialization> => {
        const response = await apiClient.post(`/courses/${id}/specializations`, data);
        return response.data;
    },

    // Remove specialization mapping
    removeSpecialization: async (courseId: number, specId: number): Promise<void> => {
        await apiClient.delete(`/courses/${courseId}/specializations/${specId}`);
    },
};
