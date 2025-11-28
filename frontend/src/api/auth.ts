import { apiClient } from './client';

export interface AuthUser {
    id: number;
    email: string;
    name: string;
    picture?: string;
}

export const authApi = {
    // Get current authenticated user
    getCurrentUser: async (): Promise<AuthUser> => {
        const response = await apiClient.get('/auth/user');
        return response.data;
    },

    // Logout
    logout: async (): Promise<void> => {
        await apiClient.post('/auth/logout');
    },

    // Initiate Google OAuth login
    loginWithGoogle: () => {
        window.location.href = 'http://localhost:8080/oauth2/authorization/google';
    },
};
