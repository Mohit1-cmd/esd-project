// TypeScript interfaces for all entities

export interface Student {
  studentId: number;
  rollNumber: string;
  firstName: string;
  lastName: string;
  email: string;
  cgpa?: number;
  totalCredits?: number;
  graduationYear?: number;
}

export interface Course {
  courseId: number;
  courseCode: string;
  courseName: string;
  description?: string;
  credits: number;
}

export interface Enrollment {
  id: number;
  studentId: number;
  studentName: string;
  courseId: number;
  courseName: string;
  courseCode: string;
  academicYear: string;
  semester?: string;
  grade?: string;
}

export interface Domain {
  domainId: number;
  domainName: string;
  description?: string;
  createdAt?: string;
  updatedAt?: string;
}

export interface Specialization {
  specializationId: number;
  specializationName: string;
  description?: string;
  createdAt?: string;
  updatedAt?: string;
}

export interface StudentSpecialization {
  studentId: number;
  rollNumber: string;
  firstName: string;
  lastName: string;
  email: string;
  specializationId: number;
  specializationName: string;
  domainName: string;
  totalCredits: number;
  hasSpecialization: boolean;
}

export interface CourseSpecialization {
  id: number;
  creditsTowardSpecialization: number;
  createdAt?: string;
}

// Request DTOs
export interface StudentRequest {
  rollNumber: string;
  firstName: string;
  lastName: string;
  email: string;
  cgpa?: number;
  totalCredits?: number;
  graduationYear?: number;
}

export interface CourseRequest {
  courseCode: string;
  courseName: string;
  description?: string;
  credits: number;
}

export interface EnrollmentRequest {
  studentId: number;
  courseId: number;
  academicYear: string;
  semester?: string;
  grade?: string;
}

export interface DomainRequest {
  domainName: string;
  description?: string;
}

export interface SpecializationRequest {
  domainId: number;
  specializationName: string;
  description?: string;
}

export interface CourseSpecializationRequest {
  specializationId: number;
  creditsTowardSpecialization: number;
}
