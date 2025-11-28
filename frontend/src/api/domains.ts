import { apiClient } from './client';
import type { Domain, DomainRequest, Specialization } from '../types';

export const domainsApi = {
    // Get all domains
    getAll: async (): Promise<Domain[]> => {
        const response = await apiClient.get('/domains');
        return response.data;
    },

    // Get domain by ID
    getById: async (id: number): Promise<Domain> => {
        const response = await apiClient.get(`/domains/${id}`);
        return response.data;
    },

    // Create domain
    create: async (data: DomainRequest): Promise<Domain> => {
        const response = await apiClient.post('/domains', data);
        return response.data;
    },

    // Update domain
    update: async (id: number, data: DomainRequest): Promise<Domain> => {
        const response = await apiClient.put(`/domains/${id}`, data);
        return response.data;
    },

    // Delete domain
    delete: async (id: number): Promise<void> => {
        await apiClient.delete(`/domains/${id}`);
    },

    // Get domain specializations
    getSpecializations: async (id: number): Promise<Specialization[]> => {
        const response = await apiClient.get(`/domains/${id}/specializations`);
        return response.data;
    },
};
