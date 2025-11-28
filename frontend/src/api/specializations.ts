import { apiClient } from './client';
import type { Specialization, SpecializationRequest, StudentSpecialization, CourseSpecialization } from '../types';

export const specializationsApi = {
    // Get all specializations
    getAll: async (domainId?: number): Promise<Specialization[]> => {
        const url = domainId ? `/specializations?domainId=${domainId}` : '/specializations';
        const response = await apiClient.get(url);
        return response.data;
    },

    // Get specialization by ID
    getById: async (id: number): Promise<Specialization> => {
        const response = await apiClient.get(`/specializations/${id}`);
        return response.data;
    },

    // Create specialization
    create: async (data: SpecializationRequest): Promise<Specialization> => {
        const response = await apiClient.post('/specializations', data);
        return response.data;
    },

    // Update specialization
    update: async (id: number, data: SpecializationRequest): Promise<Specialization> => {
        const response = await apiClient.put(`/specializations/${id}`, data);
        return response.data;
    },

    // Delete specialization
    delete: async (id: number): Promise<void> => {
        await apiClient.delete(`/specializations/${id}`);
    },

    // Get students with this specialization (>20 credits)
    getStudents: async (id: number): Promise<StudentSpecialization[]> => {
        const response = await apiClient.get(`/specializations/${id}/students`);
        return response.data;
    },

    // Get courses for this specialization
    getCourses: async (id: number): Promise<CourseSpecialization[]> => {
        const response = await apiClient.get(`/specializations/${id}/courses`);
        return response.data;
    },
};
