import axios from 'axios';

const API_BASE_URL = 'http://localhost:8080/api';

export const apiClient = axios.create({
    baseURL: API_BASE_URL,
    headers: {
        'Content-Type': 'application/json',
    },
    withCredentials: true, // Include cookies for session authentication
});

// Response interceptor for error handling
apiClient.interceptors.response.use(
    (response) => response,
    (error) => {
        if (error.response) {
            // Handle 401 Unauthorized - redirect to login
            if (error.response.status === 401) {
                // Only redirect if not already on login page or auth endpoint
                if (!window.location.pathname.includes('/login') &&
                    !error.config.url?.includes('/auth/user')) {
                    window.location.href = '/login';
                }
            }
            console.error('API Error:', error.response.data);
        } else if (error.request) {
            // Request made but no response
            console.error('Network Error:', error.request);
        } else {
            // Error in request setup
            console.error('Error:', error.message);
        }
        return Promise.reject(error);
    }
);
