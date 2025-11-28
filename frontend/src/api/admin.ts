import { apiClient } from './client';
import type { StudentSpecialization, Domain, Specialization } from '../types';

export const adminApi = {
    // Get all student specializations
    getStudentSpecializations: async (params?: { domain?: string; specializationId?: number }): Promise<StudentSpecialization[]> => {
        let url = '/admin/students/specializations';
        const queryParams = [];

        if (params?.domain) {
            queryParams.push(`domain=${encodeURIComponent(params.domain)}`);
        }
        if (params?.specializationId) {
            queryParams.push(`specializationId=${params.specializationId}`);
        }

        if (queryParams.length > 0) {
            url += '?' + queryParams.join('&');
        }

        const response = await apiClient.get(url);
        return response.data;
    },

    // Get specific student specializations (admin view)
    getStudentSpecializationsById: async (id: number): Promise<StudentSpecialization[]> => {
        const response = await apiClient.get(`/admin/students/${id}/specializations`);
        return response.data;
    },

    // Get all domains (admin view)
    getDomains: async (): Promise<Domain[]> => {
        const response = await apiClient.get('/admin/domains');
        return response.data;
    },

    // Get all specializations (admin view)
    getSpecializations: async (): Promise<Specialization[]> => {
        const response = await apiClient.get('/admin/specializations');
        return response.data;
    },
};
