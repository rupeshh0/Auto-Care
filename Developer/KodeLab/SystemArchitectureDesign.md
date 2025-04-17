# KodeLab: Comprehensive System Architecture and Implementation Guide

## 5. Database Architecture
Contents
1. [Executive Summary](#1-executive-summary)
2. [System Architecture Overview](#2-system-architecture-overview)
3. [Technical Stack](#3-technical-stack)
4. [Core Modules](#4-core-modules)
5. [Database Architecture](#5-database-architecture)
6. [API Design](#6-api-design)
7. [Frontend Architecture](#7-frontend-architecture)
8. [AI Feedback System](#8-ai-feedback-system)
9. [Code Execution Environment](#9-code-execution-environment)
10. [Security Architecture](#10-security-architecture)
11. [Error Handling and Logging](#11-error-handling-and-logging)
12. [Testing Strategy](#12-testing-strategy)
13. [DevOps and Deployment](#13-devops-and-deployment)
14. [Scalability and Performance](#14-scalability-and-performance)
15. [Academic Integration](#15-academic-integration)
16. [Code Style and Best Practices](#16-code-style-and-best-practices)
17. [Implementation Roadmap](#17-implementation-roadmap)
18. [Technical Risks and Mitigations](#18-technical-risks-and-mitigations)
19. [Platform Enhancement Recommendations](#19-platform-enhancement-recommendations)
20. [Strategic Recommendations](#20-strategic-recommendations)
21. [Implementation Plan](#21-implementation-plan)

## 1. Executive Summary

KodeLab is a comprehensive educational platform designed to bridge the gap between academic coding projects and real-world job requirements. The system provides computer science students with hands-on, production-level coding challenges and AI-driven personalized feedback to enhance job readiness.

### 1.1 Core Value Proposition

- **Real-world Coding Experience**: Challenges based on actual industry tasks
- **AI-Powered Feedback**: Personalized code reviews using industry-standard AI
- **Job Skill Alignment**: Challenges mapped to specific job requirements
- **Academic Integration**: Seamless integration with learning management systems
- **Progress Tracking**: Comprehensive analytics on skill development

### 1.2 Target Audience

- Computer science students seeking practical coding experience
- Recent graduates looking to enhance their portfolios
- Educational institutions wanting to improve job placement rates
- Self-taught programmers needing structured learning paths

This architecture document outlines a scalable, secure, and modular system that can evolve through phased implementation. The design prioritizes user experience, educational value, security, and scalability while maintaining cost efficiency.

## 2. System Architecture Overview

### 2.1 High-Level Architecture Diagram

```mermaid
flowchart TD
    Client[Student/Instructor Browser] --> FE[Frontend Layer]
    FE --> APL[API Layer]
    APL --> SRV[Service Layer]
    SRV --> DB[Data Layer]
    SRV --> AI[AI Services]
    SRV --> EXE[Code Execution]
    
    subgraph "Frontend Layer"
        NextJS[Next.js SSR/CSR]
        Components[UI Components]
        Editor[Code Editor]
        Analytics[Data Visualization]
    end
    
    subgraph "API Layer"
        REST[REST API]
        Auth[Authentication]
        Middleware[API Middleware]
    end
    
    subgraph "Service Layer"
        UserSrv[User Service]
        ChallengeSrv[Challenge Service]
        SubmissionSrv[Submission Service]
        FeedbackSrv[Feedback Service]
        AnalyticsSrv[Analytics Service]
    end
    
    subgraph "Data Layer"
        PostgreSQL[(PostgreSQL)]
        Redis[(Redis Cache)]
        Storage[(Object Storage)]
    end
    
    subgraph "AI Services"
        AIEngine[AI Feedback Engine]
        ExternalAI[OpenAI/Claude API]
        Embeddings[Vector Embeddings]
    end
    
    subgraph "Code Execution"
        Runner[Test Runner]
        Containers[Docker Containers]
        SecurityMeasures[Security Controls]
    end
```

### 2.2 Architecture Principles

1. **Modularity**: Clear separation of concerns with well-defined interfaces
2. **Scalability**: Designed for horizontal scaling with stateless components
3. **Security**: Multi-layered security approach with "defense in depth"
4. **Observability**: Comprehensive logging, monitoring, and error tracking
5. **Performance**: Optimized for responsive user experience and efficient execution
6. **Maintainability**: Consistent patterns and practices across all components

### 2.3 System Components Interaction

The following sequence diagram illustrates the core user flow of selecting and submitting a challenge:

```mermaid
sequenceDiagram
    actor Student
    participant FE as Frontend
    participant API as API Gateway
    participant Auth as Auth Service
    participant CH as Challenge Service
    participant SUB as Submission Service
    participant EXE as Code Executor
    participant AI as AI Feedback
    participant DB as Database

    Student->>FE: Login
    FE->>API: Authentication Request
    API->>Auth: Validate Credentials
    Auth->>DB: Verify User
    DB-->>Auth: User Data
    Auth-->>API: Auth Token
    API-->>FE: Auth Confirmation
    
    Student->>FE: Select Challenge
    FE->>API: Get Challenge
    API->>CH: Challenge Request
    CH->>DB: Retrieve Challenge
    DB-->>CH: Challenge Data
    CH-->>API: Challenge Details
    API-->>FE: Display Challenge
    
    Student->>FE: Submit Solution
    FE->>API: Code Submission
    API->>SUB: Process Submission
    SUB->>DB: Save Submission
    SUB->>EXE: Execute Tests
    EXE-->>SUB: Test Results
    
    alt Tests Passing
        SUB->>AI: Request Feedback
        AI->>DB: Check Similar Submissions
        AI->>AI: Generate Feedback
        AI-->>SUB: Code Feedback
        SUB->>DB: Save Feedback
        SUB-->>API: Complete Results
        API-->>FE: Display Results & Feedback
        FE-->>Student: View Results & Feedback
    else Tests Failing
        SUB-->>API: Test Failures
        API-->>FE: Display Test Failures
        FE-->>Student: View Test Failures
    end
```

### 2.4 Data Flow Architecture

```mermaid
flowchart TD
    Student((Student)) -->|1. Submits Code| CodeEditor
    CodeEditor -->|2. Code Submission| SubmissionAPI
    SubmissionAPI -->|3. Store Submission| Database
    SubmissionAPI -->|4. Execute Tests| CodeExecutor
    CodeExecutor -->|5. Test Results| SubmissionAPI
    
    subgraph "Result Processing"
        SubmissionAPI -->|6a. Failed Tests| ResultsProcessor
        SubmissionAPI -->|6b. Passed Tests| AIFeedbackService
        AIFeedbackService -->|7a. Check Cache| RedisCache
        RedisCache -->|8a. Cache Hit| AIFeedbackService
        AIFeedbackService -->|7b. Cache Miss| ExternalAI
        ExternalAI -->|8b. AI Response| AIFeedbackService
        AIFeedbackService -->|9. Process Feedback| ResultsProcessor
    end
    
    ResultsProcessor -->|10. Results & Feedback| SubmissionAPI
    SubmissionAPI -->|11. Return Results| CodeEditor
    CodeEditor -->|12. Display Results| Student
    
    class Student person
    class ExternalAI external
```

### 2.5 Environment Architecture

The system utilizes three distinct environments:

1. **Development Environment**
   - Local Docker-based setup for developer productivity
   - Mock services for external dependencies
   - Hot-reloading for rapid iteration

2. **Staging Environment**
   - Production-like configuration for testing
   - Complete integration with external services
   - Anonymized production data for testing

3. **Production Environment**
   - Fully redundant, high-availability configuration
   - Auto-scaling based on load
   - Comprehensive monitoring and alerting
  ## 3. Technical Stack

  ### 3.1 Frontend

  #### 3.1.1 Core Technologies
  - **Framework**: Next.js 14.1.0
    - Server and client components for optimal rendering strategy
    - App Router for modern routing approach
    - Server-side rendering for SEO and performance
    - Streaming for improved loading experience

  - **Language**: TypeScript 5.4.0
    - Static typing for improved development experience
    - Enhanced IDE integration and code completion
    - Type-safe patterns across the application
    - Strict configuration for maximum type safety

  - **UI Components**:
    - Tailwind CSS 3.4.0 for utility-first styling
    - shadcn/ui for accessible component library
    - Framer Motion 11.0.3 for animations
    - MDX for rich challenge content authoring

  #### 3.1.2 State Management
  - **Zustand 4.4.7**
    - Lightweight, hook-based global state management
    - Middleware support for persistence, devtools
    - TypeScript integration for type-safe state
    - Slice pattern for modular state organization

```typescript
// lib/state/editor-store.ts
import { create } from 'zustand';
import { persist } from 'zustand/middleware';

interface EditorState {
  code: string;
  language: string;
  testResults: TestResult[] | null;
  isRunning: boolean;
  isSubmitting: boolean;
  error: string | null;
  setCode: (code: string) => void;
  setLanguage: (language: string) => void;
  setTestResults: (results: TestResult[] | null) => void;
  setIsRunning: (isRunning: boolean) => void;
  setIsSubmitting: (isSubmitting: boolean) => void;
  setError: (error: string | null) => void;
  resetState: () => void;
}

export const useEditorStore = create<EditorState>()(
  persist(
    (set) => ({
      code: '',
      language: 'javascript',
      testResults: null,
      isRunning: false,
      isSubmitting: false,
      error: null,
      setCode: (code) => set({ code }),
      setLanguage: (language) => set({ language }),
      setTestResults: (testResults) => set({ testResults }),
      setIsRunning: (isRunning) => set({ isRunning }),
      setIsSubmitting: (isSubmitting) => set({ isSubmitting }),
      setError: (error) => set({ error }),
      resetState: () => set({
        code: '',
        testResults: null,
        isRunning: false,
        isSubmitting: false,
        error: null
      })
    }),
    {
      name: 'editor-store',
      partialize: (state) => ({ code: state.code, language: state.language }),
    }
  )
);
```

- **TanStack Query 5.0.0**
  - Server state management with caching
  - Automatic refetching and background updates
  - Optimistic updates for improved UX
  - Pagination and infinite loading support

```typescript
// Example TanStack Query implementation for challenge loading
export function useChallengeQuery(challengeId: string) {
  return useQuery({
    queryKey: ['challenge', challengeId],
    queryFn: () => api.challenges.getChallenge(challengeId),
    staleTime: 5 * 60 * 1000, // 5 minutes
    cacheTime: 60 * 60 * 1000, // 1 hour
    retry: 2,
    onError: (error) => {
      logger.error('Failed to fetch challenge', { challengeId, error });
    }
  });
}
```

- **React Hook Form with Zod**
  - Performant, uncontrolled form handling
  - Schema-based validation with Zod
  - Type inference from schema definitions
  - Custom validation rules and error messages

#### 3.1.3 Code Editor Integration
- **CodeMirror 6**
  - Modern, extensible code editor
  - Language support for multiple programming languages
  - Syntax highlighting and error indicators
  - Theming support for light/dark modes
  - Auto-completion and linting capabilities

### 3.2 Backend

#### 3.2.1 Core Runtime
- **Node.js 20 LTS**
  - Long-term support until April 2026
  - Modern JavaScript features and performance
  - Compatible with TypeScript and ESM
  - Efficient handling of asynchronous operations

#### 3.2.2 API Framework
- **Express.js 4.18.2**
  - RESTful API design pattern
  - Middleware architecture for cross-cutting concerns
  - Router-based organization for endpoints
  - Error handling middleware chain

```typescript
// Example Express API route implementation
import express from 'express';
import { authenticate, authorize } from '../middleware/auth';
import { validateSchema } from '../middleware/validation';
import { challengeController } from '../controllers/challenge.controller';
import { createChallengeSchema } from '../schemas/challenge.schema';

const router = express.Router();

// Public routes
router.get('/challenges', challengeController.listChallenges);
router.get('/challenges/:id', challengeController.getChallenge);
router.get('/challenges/categories', challengeController.getCategories);

// Protected routes
router.post(
  '/challenges', 
  authenticate, 
  authorize(['INSTRUCTOR', 'ADMIN']),
  validateSchema(createChallengeSchema),
  challengeController.createChallenge
);

router.put(
  '/challenges/:id', 
  authenticate, 
  authorize(['INSTRUCTOR', 'ADMIN']),
  validateSchema(updateChallengeSchema),
  challengeController.updateChallenge
);

export default router;
```

- **OpenAPI 3.0**
  - API documentation and client generation
  - Request/response schema validation
  - Interactive documentation with Swagger UI
  - Contract-first API development approach

#### 3.2.3 Authentication
- **NextAuth.js / Auth.js**
  - OAuth integration (GitHub, Google)
  - Email/password authentication
  - JWT-based session management
  - Role-based access control (RBAC)

### 3.3 Database & Storage

#### 3.3.1 Primary Database
- **PostgreSQL 16**
  - Robust relational database with ACID properties
  - JSONB support for flexible data storage
  - Vector extension for similarity search
  - Advanced indexing capabilities

#### 3.3.2 Connection Management
- **PgBouncer**
  - Connection pooling for efficient database access
  - Connection reuse and management
  - Query queuing for high-concurrency scenarios
  - Monitoring and metrics collection

#### 3.3.3 ORM
- **Prisma 5.4.2**
  - Type-safe database access with generated client
  - Schema-based migration management
  - Query building with relation support
  - Transaction support for atomic operations

#### 3.3.4 Caching
- **Redis 7.2**
  - In-memory data structure store
  - Session storage for authentication
  - Response caching for API performance
  - Queue management for asynchronous tasks
  - Rate limiting implementation

#### 3.3.5 Object Storage
- **DigitalOcean Spaces**
  - S3-compatible API for object storage
  - Submission storage for historical access
  - Asset management for challenge resources
  - Backup storage for database dumps

### 3.4 AI Integration

#### 3.4.1 External APIs
- **OpenAI GPT-4 API or Anthropic Claude**
  - Natural language processing for code analysis
  - Contextual understanding of programming concepts
  - Customizable via prompt engineering
  - Token-based pricing model

#### 3.4.2 Vector Embeddings
- **OpenAI Embeddings API**
  - Code similarity detection
  - Vector representation of code submissions
  - Efficient nearest-neighbor search
  - Dimensionality reduction for storage efficiency

#### 3.4.3 Cost Optimization
- **Multi-tiered approach**
  - Caching strategy for identical submissions
  - Pattern matching for common code structures
  - Vector similarity for similar submissions
  - AI generation only when necessary

### 3.5 DevOps

#### 3.5.1 Containerization
- **Docker 24.0.7 with Docker Compose**
  - Consistent development and production environments
  - Isolated service deployment
  - Resource limitation and monitoring
  - Multi-stage builds for optimized images

#### 3.5.2 CI/CD
- **GitHub Actions**
  - Automated testing on pull requests
  - Deployment automation for staging and production
  - Security scanning integration
  - Artifact building and versioning

#### 3.5.3 Hosting
- **DigitalOcean App Platform**
  - Managed container hosting
  - Automatic scaling based on load
  - Integrated monitoring and logging
  - Managed database and Redis services

#### 3.5.4 Monitoring
- **Sentry**
  - Error tracking and reporting
  - Performance monitoring
  - User session tracking
  - Release tracking and source maps

- **Prometheus & Grafana**
  - Metrics collection and visualization
  - Custom dashboards for system health
  - Alerting based on thresholds
  - Historical performance data

## 4. Core Modules

### 4.1 User Management Module

**Purpose**: Handle user authentication, profile management, and role-based access control.

#### 4.1.1 Authentication Service

The Authentication Service manages user identity verification, token generation, and session management.

```typescript
// backend/src/services/auth.service.ts
import { prisma } from '../lib/prisma';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { redis } from '../lib/redis';
import { logger } from '../lib/logger';
import { UnauthorizedError, ConflictError } from '../lib/errors';
import { UserDto, AuthResponse, UserRegistrationDto } from '../dto/auth.dto';

export class AuthService {
  /**
   * Authenticate a user with email and password
   * @param email User email
   * @param password User password
   * @returns Authentication response with token and user data
   * @throws UnauthorizedError if credentials are invalid
   */
  async login(email: string, password: string): Promise<AuthResponse> {
    try {
      // Validate credentials against database
      const user = await prisma.user.findUnique({ 
        where: { email },
        select: {
          id: true,
          passwordHash: true,
          role: true,
          name: true,
          email: true,
          profileImage: true,
          githubId: true,
          googleId: true
        }
      });
      
      if (!user || !await bcrypt.compare(password, user.passwordHash)) {
        throw new UnauthorizedError('Invalid credentials');
      }
      
      // Generate JWT token
      const token = this.generateToken(user.id, user.role);
      
      // Store token in Redis for validation and revocation capability
      await this.storeTokenInRedis(user.id, token);
      
      // Log successful login
      logger.info('User logged in successfully', { userId: user.id });
      
      return {
        token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role,
          profileImage: user.profileImage
        }
      };
    } catch (error) {
      // Log login failure
      logger.error('Login failed', { email, error: error.message });
      throw error;
    }
  }
  
  /**
   * Register a new user
   * @param userData User registration data
   * @returns Authentication response with token and user data
   * @throws ConflictError if email is already in use
   */
  async register(userData: UserRegistrationDto): Promise<AuthResponse> {
    try {
      // Validate email uniqueness
      const existingUser = await prisma.user.findUnique({
        where: { email: userData.email }
      });
      
      if (existingUser) {
        throw new ConflictError('Email already in use');
      }
      
      // Hash password with bcrypt (10 rounds)
      const passwordHash = await bcrypt.hash(userData.password, 10);
      
      // Create user with student role by default
      const user = await prisma.user.create({
        data: {
          email: userData.email,
          passwordHash,
          name: userData.name,
          role: 'STUDENT',
          // Initialize other user data
          settings: {
            theme: 'light',
            notifications: true
          }
        },
        select: {
          id: true,
          name: true,
          email: true,
          role: true,
          profileImage: true
        }
      });
      
      // Generate JWT token
      const token = this.generateToken(user.id, user.role);
      
      // Store token in Redis
      await this.storeTokenInRedis(user.id, token);
      
      // Log user creation
      logger.info('New user registered', { userId: user.id });
      
      return { token, user };
    } catch (error) {
      // Log registration failure
      logger.error('Registration failed', { email: userData.email, error: error.message });
      throw error;
    }
  }
  
  /**
   * Authenticate a user with GitHub OAuth
   * @param code GitHub authorization code
   * @returns Authentication response with token and user data
   */
  async githubAuth(code: string): Promise<AuthResponse> {
    try {
      // Exchange code for access token
      const githubToken = await this.exchangeGitHubCode(code);
      
      // Get user profile from GitHub
      const githubProfile = await this.getGitHubProfile(githubToken);
      
      // Find or create user
      let user = await prisma.user.findFirst({
        where: { githubId: githubProfile.id.toString() }
      });
      
      if (!user) {
        // Check if email already exists
        const existingUser = await prisma.user.findUnique({
          where: { email: githubProfile.email }
        });
        
        if (existingUser) {
          // Link GitHub to existing account
          user = await prisma.user.update({
            where: { id: existingUser.id },
            data: { githubId: githubProfile.id.toString() }
          });
        } else {
          // Create new user
          user = await prisma.user.create({
            data: {
              githubId: githubProfile.id.toString(),
              email: githubProfile.email,
              name: githubProfile.name || 'GitHub User',
              role: 'STUDENT',
              profileImage: githubProfile.avatar_url,
              settings: {
                theme: 'light',
                notifications: true
              }
            }
          });
        }
      }
      
      // Generate JWT token
      const token = this.generateToken(user.id, user.role);
      
      // Store token in Redis
      await this.storeTokenInRedis(user.id, token);
      
      // Log successful OAuth login
      logger.info('User logged in with GitHub', { userId: user.id });
      
      return {
        token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role,
          profileImage: user.profileImage
        }
      };
    } catch (error) {
      // Log OAuth failure
      logger.error('GitHub authentication failed', { error: error.message });
      throw new UnauthorizedError('GitHub authentication failed');
    }
  }
  
  /**
   * Verify a JWT token and return the associated user
   * @param token JWT token to verify
   * @returns User data
   * @throws UnauthorizedError if token is invalid
   */
  async verifyToken(token: string): Promise<UserDto> {
    try {
      // Verify token signature and expiration
      const decoded = jwt.verify(token, process.env.JWT_SECRET) as any;
      
      // Check if token has been revoked in Redis
      const isRevoked = await this.checkTokenRevoked(decoded.userId, token);
      if (isRevoked) {
        throw new UnauthorizedError('Token has been revoked');
      }
      
      // Get user from database
      const user = await prisma.user.findUnique({
        where: { id: decoded.userId },
        select: {
          id: true,
          name: true,
          email: true,
          role: true,
          profileImage: true
        }
      });
      
      if (!user) {
        throw new UnauthorizedError('User not found');
      }
      
      return user;
    } catch (error) {
      if (error.name === 'JsonWebTokenError' || error.name === 'TokenExpiredError') {
        throw new UnauthorizedError('Invalid or expired token');
      }
      throw error;
    }
  }
  
  /**
   * Logout a user by revoking their token
   * @param userId User ID
   * @param token JWT token to revoke
   */
  async logout(userId: string, token: string): Promise<void> {
    try {
      // Add token to revoked list in Redis
      await this.revokeToken(userId, token);
      logger.info('User logged out', { userId });
    } catch (error) {
      logger.error('Logout error', { userId, error: error.message });
      throw error;
    }
  }
  
  /**
   * Generate a JWT token for authentication
   * @param userId User ID
   * @param role User role
   * @returns JWT token
   * @private
   */
  private generateToken(userId: string, role: string): string {
    return jwt.sign(
      { userId, role },
      process.env.JWT_SECRET,
      { 
        expiresIn: process.env.JWT_EXPIRATION || '24h',
        issuer: 'kodelab',
        audience: 'kodelab-users'
      }
    );
  }
  
  /**
   * Store token in Redis for validation and revocation
   * @param userId User ID
   * @param token JWT token
   * @private
   */
  private async storeTokenInRedis(userId: string, token: string): Promise<void> {
    const tokenHash = this.hashToken(token);
    // Store token hash with TTL matching token expiration
    await redis.set(
      `auth:token:${userId}:${tokenHash}`, 
      '1',
      'EX',
      24 * 60 * 60 // 24 hours, matching JWT expiration
    );
  }
  
  /**
   * Check if a token has been revoked
   * @param userId User ID
   * @param token JWT token
   * @returns True if token is revoked
   * @private
   */
  private async checkTokenRevoked(userId: string, token: string): Promise<boolean> {
    const tokenHash = this.hashToken(token);
    // Check if token is in the revoked list
    const isRevoked = await redis.get(`auth:revoked:${userId}:${tokenHash}`);
    return !!isRevoked;
  }
  
  /**
   * Revoke a JWT token
   * @param userId User ID
   * @param token JWT token
   * @private
   */
  private async revokeToken(userId: string, token: string): Promise<void> {
    const tokenHash = this.hashToken(token);
    // Add to revoked list with TTL matching original expiration
    await redis.set(
      `auth:revoked:${userId}:${tokenHash}`,
      '1',
      'EX',
      24 * 60 * 60
    );
    
    // Remove from active tokens
    await redis.del(`auth:token:${userId}:${tokenHash}`);
  }
  
  /**
   * Create a hash of the token for storage
   * @param token JWT token
   * @returns Hashed token
   * @private
   */
  private hashToken(token: string): string {
    return crypto.createHash('sha256').update(token).digest('hex');
  }
  
  /**
   * Exchange GitHub code for access token
   * @param code GitHub authorization code
   * @returns GitHub access token
   * @private
   */
  private async exchangeGitHubCode(code: string): Promise<string> {
    // Implementation of GitHub OAuth code exchange
    // ... (omitted for brevity)
  }
  
  /**
   * Get GitHub profile with access token
   * @param token GitHub access token
   * @returns GitHub profile data
   * @private
   */
  private async getGitHubProfile(token: string): Promise<any> {
    // Implementation of GitHub profile fetching
    // ... (omitted for brevity)
  }
}
```

#### 4.1.2 User Profile Service

The User Profile Service handles user profile data management, settings, and preferences.

```typescript
// backend/src/services/user-profile.service.ts
import { prisma } from '../lib/prisma';
import { storage } from '../lib/storage';
import { NotFoundError, BadRequestError } from '../lib/errors';
import { logger } from '../lib/logger';
import { ProfileUpdateDto, UserProfileDto } from '../dto/user.dto';

export class UserProfileService {
  /**
   * Get user profile by ID
   * @param userId User ID
   * @returns User profile data
   * @throws NotFoundError if user not found
   */
  async getUserProfile(userId: string): Promise<UserProfileDto> {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        name: true,
        email: true,
        role: true,
        profileImage: true,
        settings: true,
        createdAt: true,
        _count: {
          select: {
            submissions: true,
            progress: {
              where: {
                status: 'COMPLETED'
              }
            }
          }
        }
      }
    });
    
    if (!user) {
      throw new NotFoundError('User not found');
    }
    
    // Get user stats
    const stats = await this.getUserStats(userId);
    
    return {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      profileImage: user.profileImage,
      settings: user.settings as any,
      createdAt: user.createdAt,
      stats: {
        totalSubmissions: user._count.submissions,
        completedChallenges: user._count.progress,
        ...stats
      }
    };
  }
  
  /**
   * Update user profile
   * @param userId User ID
   * @param profileData Profile data to update
   * @returns Updated user profile
   * @throws NotFoundError if user not found
   */
  async updateProfile(userId: string, profileData: ProfileUpdateDto): Promise<UserProfileDto> {
    // Verify user exists
    const user = await prisma.user.findUnique({
      where: { id: userId }
    });
    
    if (!user) {
      throw new NotFoundError('User not found');
    }
    
    // Handle profile image upload if present
    let profileImage = user.profileImage;
    if (profileData.profileImageBase64) {
      profileImage = await this.uploadProfileImage(userId, profileData.profileImageBase64);
    }
    
    // Update user profile
    const updatedUser = await prisma.user.update({
      where: { id: userId },
      data: {
        name: profileData.name,
        settings: profileData.settings ? {
          ...user.settings as any,
          ...profileData.settings
        } : undefined,
        profileImage
      },
      select: {
        id: true,
        name: true,
        email: true,
        role: true,
        profileImage: true,
        settings: true,
        createdAt: true,
        _count: {
          select: {
            submissions: true,
            progress: {
              where: {
                status: 'COMPLETED'
              }
            }
          }
        }
      }
    });
    
    // Get user stats
    const stats = await this.getUserStats(userId);
    
    return {
      id: updatedUser.id,
      name: updatedUser.name,
      email: updatedUser.email,
      role: updatedUser.role,
      profileImage: updatedUser.profileImage,
      settings: updatedUser.settings as any,
      createdAt: updatedUser.createdAt,
      stats: {
        totalSubmissions: updatedUser._count.submissions,
        completedChallenges: updatedUser._count.progress,
        ...stats
      }
    };
  }
  
  /**
   * Upload profile image and return the URL
   * @param userId User ID
   * @param base64Image Base64 encoded image
   * @returns URL of uploaded image
   * @private
   */
  private async uploadProfileImage(userId: string, base64Image: string): Promise<string> {
    try {
      // Validate base64 image
      if (!base64Image.startsWith('data:image/')) {
        throw new BadRequestError('Invalid image format');
      }
      
      // Extract content type and image data
      const [header, imageData] = base64Image.split(',');
      const contentType = header.split(':')[1].split(';')[0];
      
      // Decode base64
      const buffer = Buffer.from(imageData, 'base64');
      
      // Validate file size (max 2MB)
      if (buffer.length > 2 * 1024 * 1024) {
        throw new BadRequestError('Image too large. Maximum size is 2MB');
      }
      
      // Generate filename
      const filename = `profiles/${userId}/${Date.now()}.${contentType.split('/')[1]}`;
      
      // Upload to storage (DigitalOcean Spaces)
      const url = await storage.uploadBuffer(buffer, filename, contentType);
      
      return url;
    } catch (error) {
      logger.error('Profile image upload failed', { userId, error: error.message });
      throw error;
    }
  }
  
  /**
   * Get user statistics
   * @param userId User ID
   * @returns User statistics
   * @private
   */
  private async getUserStats(userId: string): Promise<any> {
    // Get average score of passed submissions
    const scoreStats = await prisma.submission.aggregate({
      where: {
        userId,
        status: 'PASSED'
      },
      _avg: {
        score: true
      },
      _count: true
    });
    
    // Get category completion stats
    const categoryStats = await prisma.$queryRaw`
      SELECT c.category, 
             COUNT(DISTINCT c.id) as total, 
             COUNT(DISTINCT CASE WHEN p.status = 'COMPLETED' THEN c.id ELSE NULL END) as completed
      FROM "Challenge" c
      LEFT JOIN "Progress" p ON c.id = p."challengeId" AND p."userId" = ${userId}
      WHERE c."isPublic" = true
      GROUP BY c.category
    `;
    
    // Get difficulty distribution
    const difficultyStats = await prisma.$queryRaw`
      SELECT c.difficulty, 
             COUNT(DISTINCT c.id) as total, 
             COUNT(DISTINCT CASE WHEN p.status = 'COMPLETED' THEN c.id ELSE NULL END) as completed
      FROM "Challenge" c
      LEFT JOIN "Progress" p ON c.id = p."challengeId" AND p."userId" = ${userId}
      WHERE c."isPublic" = true
      GROUP BY c.difficulty
    `;
    
    return {
      averageScore: scoreStats._avg.score || 0,
      totalPassed: scoreStats._count || 0,
      categoryCompletion: categoryStats,
      difficultyCompletion: difficultyStats
    };
  }
}
```

#### 4.1.3 Role Management Implementation

User roles are implemented using a role-based access control system:

1. **Student Role**:
   - Default role for all new users
   - Access to challenges, submissions, feedback
   - View personal progress and analytics

2. **Instructor Role**:
   - All student capabilities
   - Create and manage challenges
   - View student submissions and progress
   - Manage courses and assignments

3. **Administrator Role**:
   - All instructor capabilities
   - User management
   - System configuration
   - Analytics and reporting across all users

```typescript
// backend/src/middleware/auth.middleware.ts
import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { prisma } from '../lib/prisma';
import { redis } from '../lib/redis';
import { UnauthorizedError, ForbiddenError } from '../lib/errors';
import { logger } from '../lib/logger';

export interface AuthRequest extends Request {
  user?: {
    id: string;
    role: string;
  };
}

/**
 * Middleware to authenticate requests using JWT
 */
export const authenticate = async (
  req: AuthRequest, 
  res: Response, 
  next: NextFunction
) => {
  try {
    // Get token from Authorization header
    const authHeader = req.headers.authorization;
    
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new UnauthorizedError('No token provided');
    }
    
    const token = authHeader.split(' ')[1];
    
    // Verify token
    const decoded = jwt.verify(token, process.env.JWT_SECRET) as any;
    
    // Check if token has required fields
    if (!decoded.userId) {
      throw new UnauthorizedError('Invalid token');
    }
    
    // Check if token has been revoked
    const tokenHash = crypto.createHash('sha256').update(token).digest('hex');
    const isRevoked = await redis.get(`auth:revoked:${decoded.userId}:${tokenHash}`);
    
    if (isRevoked) {
      throw new UnauthorizedError('Token has been revoked');
    }
    
    // Verify user exists
    const user = await prisma.user.findUnique({
      where: { id: decoded.userId },
      select: { id: true, role: true }
    });
    
    if (!user) {
      throw new UnauthorizedError('User not found');
    }
    
    // Attach user to request
    req.user = {
      id: user.id,
      role: user.role
    };
    
    // Update last activity timestamp
    await redis.set(`user:lastActive:${user.id}`, Date.now().toString(), 'EX', 60 * 60 * 24 * 7); // 7 days
    
    next();
  } catch (error) {
    logger.error('Authentication error', { error: error.message, path: req.path });
    
    if (error.name === 'JsonWebTokenError' || error.name === 'TokenExpiredError') {
      next(new UnauthorizedError('Invalid or expired token'));
    } else {
      next(error);
    }
  }
};

/**
 * Middleware to authorize requests based on user roles
 * @param roles Array of allowed roles
 */
export const authorize = (roles: string[]) => {
  return (req: AuthRequest, res: Response, next: NextFunction) => {
    if (!req.user) {
      throw new UnauthorizedError('Authentication required');
    }
    
    if (!roles.includes(req.user.role)) {
      logger.warn('Unauthorized access attempt', { 
        userId: req.user.id, 
        role: req.user.role, 
        requiredRoles: roles,
        path: req.path
      });
      
      throw new ForbiddenError('Insufficient permissions');
    }
    
    next();
  };
};

/**
 * Middleware to verify resource ownership
 * @param resourceType Type of resource to check
 * @param paramName Request parameter containing resource ID
 */
export const verifyOwnership = (resourceType: string, paramName: string = 'id') => {
  return async (req: AuthRequest, res: Response, next: NextFunction) => {
    if (!req.user) {
      throw new UnauthorizedError('Authentication required');
    }
    
    // Admin can access any resource
    if (req.user.role === 'ADMIN') {
      return next();
    }
    
    const resourceId = req.params[paramName];
    
    if (!resourceId) {
      throw new BadRequestError(`No ${paramName} provided`);
    }
    
    try {
      let isOwner = false;
      
      // Check ownership based on resource type
      switch (resourceType) {
        case 'challenge':
          const challenge = await prisma.challenge.findUnique({
            where: { id: resourceId },
            select: { createdById: true }
          });
          isOwner = challenge?.createdById === req.user.id;
          break;
        
        case 'submission':
          const submission = await prisma.submission.findUnique({
            where: { id: resourceId },
            select: { userId: true }
          });
          isOwner = submission?.userId === req.user.id;
          break;
        
        case 'course':
          const course = await prisma.course.findUnique({
            where: { id: resourceId },
            select: { instructorId: true }
          });
          isOwner = course?.instructorId === req.user.id;
          break;
          
        // Add other resource types as needed
        
        default:
          throw new Error(`Unknown resource type: ${resourceType}`);
      }
      
      if (!isOwner) {
        logger.warn('Unauthorized resource access', { 
          userId: req.user.id,
          resourceType,
          resourceId,
          path: req.path
        });
        
        throw new ForbiddenError('You do not have permission to access this resource');
      }
      
      next();
    } catch (error) {
      next(error);
    }
  };
};
```

### 4.2 Challenge Engine Module

**Purpose**: Provide a comprehensive system for creating, managing, and delivering coding challenges.

#### 4.2.1 Challenge Repository Implementation

The Challenge Repository manages the creation, storage, and retrieval of coding challenges:

```typescript
// backend/src/services/challenge.service.ts
import { prisma } from '../lib/prisma';
import { redis } from '../lib/redis';
import { storage } from '../lib/storage';
import { NotFoundError, BadRequestError, ForbiddenError } from '../lib/errors';
import { logger } from '../lib/logger';
import { 
  ChallengeDetailDto, 
  ChallengeListDto, 
  CreateChallengeDto, 
  UpdateChallengeDto,
  ChallengeFilters
} from '../dto/challenge.dto';

export class ChallengeService {
  /**
   * Get challenge by ID
   * @param id Challenge ID
   * @param userId User ID for progress tracking
   * @returns Challenge details
   * @throws NotFoundError if challenge not found
   */
  async getChallenge(id: string, userId?: string): Promise<ChallengeDetailDto> {
    // Try to get from cache first
    const cacheKey = `challenge:${id}:${userId || 'anonymous'}`;
    const cachedChallenge = await redis.get(cacheKey);
    
    if (cachedChallenge) {
      return JSON.parse(cachedChallenge);
    }
    
    // Get challenge from database
    const challenge = await prisma.challenge.findUnique({
      where: { id },
      include: {
        createdBy: {
          select: {
            id: true,
            name: true
          }
        }
      }
    });
    
    if (!challenge) {
      throw new NotFoundError('Challenge not found');
    }
    
    // Check if challenge is public or user is creator/admin
    if (!challenge.isPublic && userId !== challenge.createdById) {
      // Check if user is admin
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { role: true }
      });
      
      if (!user || user.role !== 'ADMIN') {
        throw new ForbiddenError('You do not have permission to access this challenge');
      }
    }
    
    let progress = null;
    let currentCode = challenge.starterCode;
    
    // Get user progress if userId provided
    if (userId) {
      progress = await prisma.progress.findUnique({
        where: {
          userId_challengeId: {
            userId,
            challengeId: id
          }
        }
      });
      
      // Get user's last submission if available
      if (progress) {
        const lastSubmission = await prisma.submission.findFirst({
          where: { 
            userId,
            challengeId: id
          },
          orderBy: { createdAt: 'desc' },
          select: { codeSubmitted: true }
        });
        
        if (lastSubmission) {
          currentCode = lastSubmission.codeSubmitted;
        }
      }
    }
    
    // Structure user-friendly test cases (hide solutions for non-public test cases)
    const publicTestCases = challenge.testCases.map(testCase => ({
      id: testCase.id,
      description: testCase.description,
      input: testCase.input,
      expectedOutput: testCase.isPublic ? testCase.expectedOutput : null,
      isPublic: testCase.isPublic
    }));
    
    // Construct response
    const response: ChallengeDetailDto = {
      id: challenge.id,
      title: challenge.title,
      description: challenge.description,
      difficulty: challenge.difficulty,
      category: challenge.category,
      instructions: challenge.instructions,
      starterCode: currentCode,
      testCases: publicTestCases,
      hints: challenge.hints || [],
      tags: challenge.tags,
      estimatedTime: challenge.estimatedTime,
      createdBy: challenge.createdBy,
      createdAt: challenge.createdAt,
      updatedAt: challenge.updatedAt,
      isPublic: challenge.isPublic,
      progress: progress ? {
        status: progress.status,
        attemptsCount: progress.attemptsCount,
        firstAttemptedAt: progress.firstAttemptedAt,
        completedAt: progress.completedAt
      } : null
    };
    
    // Cache the challenge
    await redis.set(cacheKey, JSON.stringify(response), 'EX', 60 * 5); // 5 minutes cache
    
    return response;
  }
  
  /**
   * List challenges with filtering and pagination
   * @param filters Challenge filters
   * @param userId Optional user ID for progress tracking
   * @returns Paginated list of challenges
   */
  async listChallenges(filters: ChallengeFilters, userId?: string): Promise<ChallengeListDto> {
    const { 
      difficulty, 
      category, 
      tags, 
      search, 
      page = 1, 
      limit = 20,
      sortBy = 'createdAt',
      sortOrder = 'desc'
    } = filters;
    
    // Cache key based on filters and user
    const cacheKey = `challenges:${JSON.stringify(filters)}:${userId || 'anonymous'}`;
    const cachedResult = await redis.get(cacheKey);
    
    if (cachedResult) {
      return JSON.parse(cachedResult);
    }
    
    // Build where clause based on filters
    const where: any = { isPublic: true };
    
    if (difficulty) {
      where.difficulty = difficulty;
    }
    
    if (category) {
      where.category = category;
    }
    
    if (tags && tags.length > 0) {
      where.tags = { hasEvery: tags };
    }
    
    if (search) {
      where.OR = [
        { title: { contains: search, mode: 'insensitive' } },
        { description: { contains: search, mode: 'insensitive' } },
        { tags: { hasSome: [search] } }
      ];
    }
    
    // Count total challenges matching filters
    const total = await prisma.challenge.count({ where });
    
    // Determine sort configuration
    const orderBy: any = {};
    orderBy[sortBy] = sortOrder;
    
    // Get paginated challenges
    const challenges = await prisma.challenge.findMany({
      where,
      select: {
        id: true,
        title: true,
        description: true,
        difficulty: true,
        category: true,
        tags: true,
        estimatedTime: true,
        createdAt: true,
        _count: {
          select: { submissions: true }
        }
      },
      skip: (page - 1) * limit,
      take: limit,
      orderBy
    });
    
    // Get progress for each challenge if userId provided
    let progressMap = {};
    if (userId) {
      const challengeIds = challenges.map(c => c.id);
      const progress = await prisma.progress.findMany({
        where: {
          userId,
          challengeId: { in: challengeIds }
        }
      });
      
      progressMap = progress.reduce((map, item) => {
        map[item.challengeId] = item;
        return map;
      }, {});
    }
    
    // Build response
    const result: ChallengeListDto = {
      challenges: challenges.map(challenge => ({
        id: challenge.id,
        title: challenge.title,
        description: challenge.description,
        difficulty: challenge.difficulty,
        category: challenge.category,
        tags: challenge.tags,
        estimatedTime: challenge.estimatedTime,
        submissionCount: challenge._count.submissions,
        createdAt: challenge.createdAt,
        progress: progressMap[challenge.id] ? {
          status: progressMap[challenge.id].status,
          completedAt: progressMap[challenge.id].completedAt
        } : null
      })),
      pagination: {
        page,
        limit,
        total,
        pages: Math.ceil(total / limit)
      }
    };
    
    // Cache results
    await redis.set(cacheKey, JSON.stringify(result), 'EX', 60 * 2); // 2 minutes cache
    
    return result;
  }
  
  /**
   * Create a new challenge
   * @param userId Creator user ID
   * @param challengeData Challenge data
   * @returns Created challenge
   */
  async createChallenge(userId: string, challengeData: CreateChallengeDto): Promise<ChallengeDetailDto> {
    try {
      // Validate user role
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { role: true, name: true }
      });
      
      if (!user || (user.role !== 'INSTRUCTOR' && user.role !== 'ADMIN')) {
        throw new ForbiddenError('Only instructors and admins can create challenges');
      }
      
      // Validate test cases
      this.validateTestCases(challengeData.testCases);
      
      // Create challenge
      const challenge = await prisma.challenge.create({
        data: {
          title: challengeData.title,
          description: challengeData.description,
          difficulty: challengeData.difficulty,
          category: challengeData.category,
          instructions: challengeData.instructions,
          starterCode: challengeData.starterCode,
          solutionCode: challengeData.solutionCode,
          testCases: challengeData.testCases,
          hints: challengeData.hints || [],
          tags: challengeData.tags || [],
          estimatedTime: challengeData.estimatedTime,
          isPublic: challengeData.isPublic ?? true,
          createdById: userId
        },
        include: {
          createdBy: {
            select: {
              id: true,
              name: true
            }
          }
        }
      });
      
      // Clear challenges cache
      await this.invalidateChallengesCache();
      
      logger.info('Challenge created', { 
        challengeId: challenge.id, 
        userId,
        title: challenge.title
      });
      
      return {
        id: challenge.id,
        title: challenge.title,
        description: challenge.description,
        difficulty: challenge.difficulty,
        category: challenge.category,
        instructions: challenge.instructions,
        starterCode: challenge.starterCode,
        testCases: challenge.testCases,
        hints: challenge.hints || [],
        tags: challenge.tags,
        estimatedTime: challenge.estimatedTime,
        createdBy: challenge.createdBy,
        createdAt: challenge.createdAt,
        updatedAt: challenge.updatedAt,
        isPublic: challenge.isPublic,
        progress: null
      };
    } catch (error) {
      logger.error('Challenge creation failed', { 
        userId, 
        error: error.message,
        title: challengeData.title
      });
      throw error;
    }
  }
  
  /**
   * Update an existing challenge
   * @param id Challenge ID
   * @param userId User ID performing the update
   * @param challengeData Updated challenge data
   * @returns Updated challenge
   * @throws NotFoundError if challenge not found
   * @throws ForbiddenError if user is not creator or admin
   */
  async updateChallenge(id: string, userId: string, challengeData: UpdateChallengeDto): Promise<ChallengeDetailDto> {
    // Get challenge to check ownership
    const challenge = await prisma.challenge.findUnique({
      where: { id },
      select: { 
        id: true, 
        createdById: true,
        testCases: true
      }
    });
    
    if (!challenge) {
      throw new NotFoundError('Challenge not found');
    }
    
    // Check if user is creator or admin
    if (challenge.createdById !== userId) {
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { role: true }
      });
      
      if (!user || user.role !== 'ADMIN') {
        throw new ForbiddenError('You do not have permission to update this challenge');
      }
    }
    
    // Validate test cases if provided
    if (challengeData.testCases) {
      this.validateTestCases(challengeData.testCases);
    }
    
    // Update challenge
    const updatedChallenge = await prisma.challenge.update({
      where: { id },
      data: {
        title: challengeData.title,
        description: challengeData.description,
        difficulty: challengeData.difficulty,
        category: challengeData.category,
        instructions: challengeData.instructions,
        starterCode: challengeData.starterCode,
        solutionCode: challengeData.solutionCode,
        testCases: challengeData.testCases,
        hints: challengeData.hints,
        tags: challengeData.tags,
        estimatedTime: challengeData.estimatedTime,
        isPublic: challengeData.isPublic
      },
      include: {
        createdBy: {
          select: {
            id: true,
            name: true
          }
        }
      }
    });
    
    // Invalidate caches
    await this.invalidateChallengeCaches(id);
    
    logger.info('Challenge updated', { 
      challengeId: id, 
      userId,
      title: updatedChallenge.title
    });
    
    return {
      id: updatedChallenge.id,
      title: updatedChallenge.title,
      description: updatedChallenge.description,
      difficulty: updatedChallenge.difficulty,
      category: updatedChallenge.category,
      instructions: updatedChallenge.instructions,
      starterCode: updatedChallenge.starterCode,
      testCases: updatedChallenge.testCases,
      hints: updatedChallenge.hints || [],
      tags: updatedChallenge.tags,
      estimatedTime: updatedChallenge.estimatedTime,
      createdBy: updatedChallenge.createdBy,
      createdAt: updatedChallenge.createdAt,
      updatedAt: updatedChallenge.updatedAt,
      isPublic: updatedChallenge.isPublic,
      progress: null
    };
  }
  
  /**
   * Delete a challenge
   * @param id Challenge ID
   * @param userId User ID performing the deletion
   * @throws NotFoundError if challenge not found
   * @throws ForbiddenError if user is not creator or admin
   */
  async deleteChallenge(id: string, userId: string): Promise<void> {
    // Get challenge to check ownership
    const challenge = await prisma.challenge.findUnique({
      where: { id },
      select: { 
        id: true, 
        createdById: true,
        title: true
      }
    });
    
    if (!challenge) {
      throw new NotFoundError('Challenge not found');
    }
    
    // Check if user is creator or admin
    if (challenge.createdById !== userId) {
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { role: true }
      });
      
      if (!user || user.role !== 'ADMIN') {
        throw new ForbiddenError('You do not have permission to delete this challenge');
      }
    }
    
    // Check if challenge has submissions
    const submissionCount = await prisma.submission.count({
      where: { challengeId: id }
    });
    
    if (submissionCount > 0) {
      // Soft delete by marking as not public and updating title
      await prisma.challenge.update({
        where: { id },
        data: {
          isPublic: false,
          title: `[DELETED] ${challenge.title}`
        }
      });
    } else {
      // Hard delete if no submissions
      await prisma.challenge.delete({
        where: { id }
      });
    }
    
    // Invalidate caches
    await this.invalidateChallengeCaches(id);
    
    logger.info('Challenge deleted', { 
      challengeId: id, 
      userId,
      title: challenge.title,
      softDelete: submissionCount > 0
    });
  }
  
  /**
   * Get all challenge categories
   * @returns Array of unique categories
   */
  async getCategories(): Promise<string[]> {
    // Try to get from cache
    const cacheKey = 'challenge:categories';
    const cachedCategories = await redis.get(cacheKey);
    
    if (cachedCategories) {
      return JSON.parse(cachedCategories);
    }
    
    // Get unique categories from database
    const categoriesResult = await prisma.$queryRaw`
      SELECT DISTINCT category FROM "Challenge"
      WHERE "isPublic" = true
      ORDER BY category ASC
    `;
    
    const categories = categoriesResult.map(row => row.category);
    
    // Cache for 1 hour
    await redis.set(cacheKey, JSON.stringify(categories), 'EX', 60 * 60);
    
    return categories;
  }
  
  /**
   * Validate test cases format and content
   * @param testCases Test cases to validate
   * @throws BadRequestError if test cases are invalid
   * @private
   */
  private validateTestCases(testCases: any[]): void {
    if (!Array.isArray(testCases) || testCases.length === 0) {
      throw new BadRequestError('At least one test case is required');
    }
    
    // Ensure each test case has required fields
    testCases.forEach((testCase, index) => {
      if (!testCase.description) {
        throw new BadRequestError(`Test case ${index + 1} is missing a description`);
      }
      
      if (!testCase.functionName) {
        throw new BadRequestError(`Test case ${index + 1} is missing a function name`);
      }
      
      if (testCase.input === undefined) {
        throw new BadRequestError(`Test case ${index + 1} is missing input`);
      }
      
      if (testCase.expectedOutput === undefined) {
        throw new BadRequestError(`Test case ${index + 1} is missing expected output`);
      }
    });
  }
  
  /**
   * Invalidate all caches related to a specific challenge
   * @param challengeId Challenge ID
   * @private
   */
  private async invalidateChallengeCaches(challengeId: string): Promise<void> {
    // Delete challenge detail caches
    const keys = await redis.keys(`challenge:${challengeId}:*`);
    
    if (keys.length > 0) {
      await redis.del(keys);
    }
    
    // Invalidate challenge list caches
    await this.invalidateChallengesCache();
  }
  
  /**
   * Invalidate all challenge list caches
   * @private
   */
  private async invalidateChallengesCache(): Promise<void> {
    const keys = await redis.keys('challenges:*');
    
    if (keys.length > 0) {
      await redis.del(keys);
    }
    
    // Also invalidate categories cache
    await redis.del('challenge:categories');
  }
}
```

#### 4.2.2 Code Editor Integration

The code editor is implemented using CodeMirror 6, with support for multiple programming languages and features like syntax highlighting, auto-completion, and error indicators:

```tsx
// components/challenge/editor.tsx
'use client';

import { useState, useEffect, useRef } from 'react';
import { useEditorStore } from '@/lib/state/editor-store';
import { Extension } from '@codemirror/state';
import { 
  EditorView, 
  keymap, 
  lineNumbers, 
  highlightActiveLine,
  highlightSpecialChars,
  drawSelection,
  dropCursor
} from '@codemirror/view';
import { 
  defaultKeymap, 
  history, 
  historyKeymap,
  indentWithTab
} from '@codemirror/commands';
import { 
  indentOnInput, 
  bracketMatching,
  foldGutter,
  foldKeymap
} from '@codemirror/language';
import { searchKeymap } from '@codemirror/search';
import { linter, lintGutter } from '@codemirror/lint';
import { javascript } from '@codemirror/lang-javascript';
import { python } from '@codemirror/lang-python';
import { java } from '@codemirror/lang-java';
import { cpp } from '@codemirror/lang-cpp';
import { html } from '@codemirror/lang-html';
import { css } from '@codemirror/lang-css';
import { oneDark } from '@codemirror/theme-one-dark';
import { autocompletion, completionKeymap } from '@codemirror/autocomplete';
import { Button } from '../ui/button';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '../ui/select';
import { toast } from '../ui/use-toast';
import { ErrorHighlight } from './error-highlight';

export interface TestError {
  line: number;
  message: string;
  severity: 'error' | 'warning' | 'info';
}

interface CodeEditorProps {
  initialCode: string;
  language: string;
  onChange?: (code: string) => void;
  onRun?: () => void;
  onSubmit?: () => void;
  readOnly?: boolean;
  errors?: TestError[];
  isRunning?: boolean;
  isSubmitting?: boolean;
  height?: string;
  showLanguageSelector?: boolean;
}

const languageExtensions: Record<string, Extension> = {
  javascript: javascript(),
  typescript: javascript({ typescript: true }),
  python: python(),
  java: java(),
  cpp: cpp(),
  'c++': cpp(),
  html: html(),
  css: css(),
};

/**
 * Advanced code editor component with multiple features:
 * - Syntax highlighting for multiple languages
 * - Line numbers and active line highlighting
 * - Bracket matching and auto-indentation
 * - Error highlighting from test results
 * - Folding capabilities for code sections
 * - Auto-completion based on language
 * - Dark theme with customizable appearance
 */
export function CodeEditor({ 
  initialCode = '', 
  language = 'javascript',
  onChange,
  onRun,
  onSubmit,
  readOnly = false,
  errors = [],
  isRunning = false,
  isSubmitting = false,
  height = '500px',
  showLanguageSelector = true
}: CodeEditorProps) {
  const { code, setCode, setLanguage: setStoreLanguage } = useEditorStore();
  const [element, setElement] = useState<HTMLElement | null>(null);
  const [view, setView] = useState<EditorView | null>(null);
  
  // Local state for language selection
  const [selectedLanguage, setSelectedLanguage] = useState(language);
  
  // Initialize editor with code from store or props
  useEffect(() => {
    // Initialize code in store if coming from props
    if (initialCode && (!code || code === '')) {
      setCode(initialCode);
    }
  }, [initialCode, code, setCode]);
  
  // Update when errors change
  useEffect(() => {
    if (!view || !errors.length) return;
    
    // Refresh view to show errors
    view.dispatch({});
  }, [errors, view]);
  
  // Create custom linter based on errors
  const errorLinter = linter((view) => {
    if (!errors.length) return [];
    
    return errors.map(error => {
      // Find the position in the document for the line
      const line = view.state.doc.line(error.line);
      
      return {
        from: line.from,
        to: line.to,
        severity: error.severity,
        message: error.message
      };
    });
  });
  
  // Configure and create editor
  useEffect(() => {
    if (!element) return;
    if (view) {
      // Destroy existing view if language changes
      if (view.state.languageDataAt('linguistLanguageName', 0)[0] !== selectedLanguage) {
        view.destroy();
        setView(null);
        return;
      }
      return;
    }
    
    const languageExt = languageExtensions[selectedLanguage] || languageExtensions.javascript;
    
    const extensions: Extension[] = [
      // Essential extensions
      lineNumbers(),
      highlightActiveLine(),
      highlightSpecialChars(),
      history(),
      drawSelection(),
      dropCursor(),
      EditorView.lineWrapping,
      
      // Indentation and brackets
      indentOnInput(),
      bracketMatching(),
      
      // Folding
      foldGutter(),
      
      // Language support
      languageExt,
      
      // Auto-completion
      autocompletion({
        override: [
          // Custom completions can be added here
        ]
      }),
      
      // Error highlighting
      lintGutter(),
      errorLinter,
      
      // Dark theme
      oneDark,
      
      // Key mappings
      keymap.of([
        ...defaultKeymap,
        ...historyKeymap,
        ...foldKeymap,
        ...searchKeymap,
        ...completionKeymap,
        indentWithTab
      ]),
      
      // Update callback
      EditorView.updateListener.of(update => {
        if (update.docChanged) {
          const newCode = update.state.doc.toString();
          setCode(newCode);
          onChange?.(newCode);
        }
      })
    ];
    
    // Add readonly if needed
    if (readOnly) {
      extensions.push(EditorView.editable.of(false));
    }
    
    // Create editor view
    const newView = new EditorView({
      doc: code || initialCode,
      extensions,
      parent: element
    });
    
    setView(newView);
    
    // Cleanup on unmount
    return () => {
      newView.destroy();
    };
  }, [element, view, selectedLanguage, code, initialCode, onChange, readOnly, setCode, errors]);
  
  // Update editor content when code changes externally
  useEffect(() => {
    if (!view || !code) return;
    
    const currentCode = view.state.doc.toString();
    if (currentCode !== code) {
      view.dispatch({
        changes: { from: 0, to: currentCode.length, insert: code }
      });
    }
  }, [code, view]);
  
  // Handle language change
  const handleLanguageChange = (newLanguage: string) => {
    setSelectedLanguage(newLanguage);
    setStoreLanguage(newLanguage);
    
    // Force view recreation by destroying it
    if (view) {
      view.destroy();
      setView(null);
    }
    
    toast({
      title: "Language changed",
      description: `Editor language set to ${newLanguage}`
    });
  };
  
  // Handle keyboard shortcuts
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      // Ctrl+Enter or Cmd+Enter to run
      if ((e.ctrlKey || e.metaKey) && e.key === 'Enter' && onRun) {
        e.preventDefault();
        onRun();
      }
      
      // Ctrl+S or Cmd+S to submit
      if ((e.ctrlKey || e.metaKey) && e.key === 's' && onSubmit) {
        e.preventDefault();
        onSubmit();
      }
    };
    
    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, [onRun, onSubmit]);
  
  return (
    <div className="border rounded-md overflow-hidden bg-gray-900 flex flex-col">
      <div className="flex items-center justify-between bg-gray-800 px-4 py-2">
        <div className="flex items-center space-x-4">
          {showLanguageSelector ? (
            <Select 
              value={selectedLanguage} 
              onValueChange={handleLanguageChange}
              disabled={readOnly}
            >
              <SelectTrigger className="w-[140px] bg-gray-700 border-gray-600">
                <SelectValue placeholder="Language" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="javascript">JavaScript</SelectItem>
                <SelectItem value="typescript">TypeScript</SelectItem>
                <SelectItem value="python">Python</SelectItem>
                <SelectItem value="java">Java</SelectItem>
                <SelectItem value="cpp">C++</SelectItem>
                <SelectItem value="html">HTML</SelectItem>
                <SelectItem value="css">CSS</SelectItem>
              </SelectContent>
            </Select>
          ) : (
            <div className="text-sm font-mono text-gray-200">
              {selectedLanguage.toUpperCase()}
            </div>
          )}
        </div>
        
        <div className="flex space-x-2">
          {onRun && (
            <Button 
              variant="outline" 
              size="sm"
              onClick={onRun}
              disabled={isRunning || isSubmitting || readOnly}
            >
              {isRunning ? "Running..." : "Run Code"}
            </Button>
          )}
          
          {onSubmit && (
            <Button 
              size="sm"
              onClick={onSubmit}
              disabled={isRunning || isSubmitting || readOnly}
            >
              {isSubmitting ? "Submitting..." : "Submit"}
            </Button>
          )}
        </div>
      </div>
      
      <div className="relative">
        <div 
          ref={setElement} 
          className={`overflow-auto`}
          style={{ height }}
        />
        
        {/* Overlay error highlights */}
        {errors.length > 0 && view && (
          <ErrorHighlight 
            errors={errors} 
            editorView={view} 
          />
        )}
      </div>
    </div>
  );
}
```

#### 4.2.3 Test Runner Implementation

The Test Runner orchestrates secure code execution and validates the results:

```typescript
// backend/src/controllers/submission.controller.ts
import { Request, Response, NextFunction } from 'express';
import { AuthRequest } from '../middleware/auth';
import { submissionService } from '../services/submission.service';
import { logger } from '../lib/logger';
import { CreateSubmissionDto } from '../dto/submission.dto';

export const submissionController = {
  /**
   * Submit code for a challenge
   * @route POST /api/submissions
   */
  async submitCode(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const userId = req.user.id;
      
      const submissionData: CreateSubmissionDto = {
        userId,
        challengeId: req.body.challengeId,
        code: req.body.code,
        language: req.body.language
      };
      
      logger.info('Submission received', { 
        userId, 
        challengeId: submissionData.challengeId,
        language: submissionData.language
      });
      
      const result = await submissionService.submitCode(submissionData);
      
      res.status(201).json(result);
    } catch (error) {
      logger.error('Submission failed', { 
        userId: req.user?.id, 
        error: error.message,
        challengeId: req.body.challengeId
      });
      next(error);
    }
  },
  
  /**
   * Get submission details
   * @route GET /api/submissions/:id
   */
  async getSubmission(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const userId = req.user.id;
      const submissionId = req.params.id;
      
      const submission = await submissionService.getSubmission(submissionId, userId);
      
      res.status(200).json(submission);
    } catch (error) {
      logger.error('Get submission failed', { 
        userId: req.user?.id, 
        error: error.message,
        submissionId: req.params.id
      });
      next(error);
    }
  },
  
  /**
   * Get submission feedback
   * @route GET /api/submissions/:id/feedback
   */
  async getSubmissionFeedback(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const userId = req.user.id;
      const submissionId = req.params.id;
      
      const feedback = await submissionService.getSubmissionFeedback(submissionId, userId);
      
      res.status(200).json(feedback);
    } catch (error) {
      logger.error('Get submission feedback failed', { 
        userId: req.user?.id, 
        error: error.message,
        submissionId: req.params.id
      });
      next(error);
    }
  },
  
  /**
   * Regenerate submission feedback
   * @route POST /api/submissions/:id/feedback/regenerate
   */
  async regenerateFeedback(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const userId = req.user.id;
      const submissionId = req.params.id;
      
      logger.info('Feedback regeneration requested', { 
        userId, 
        submissionId
      });
      
      const result = await submissionService.regenerateFeedback(submissionId, userId);
      
      res.status(202).json(result);
    } catch (error) {
      logger.error('Feedback regeneration failed', { 
        userId: req.user?.id, 
        error: error.message,
        submissionId: req.params.id
      });
      next(error);
    }
  },
  
  /**
   * Check status of feedback generation job
   * @route GET /api/submissions/feedback/job/:jobId
   */
  async checkFeedbackJob(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const userId = req.user.id;
      const jobId = req.params.jobId;
      
      const result = await submissionService.checkFeedbackJob(jobId, userId);
      
      res.status(200).json(result);
    } catch (error) {
      logger.error('Check feedback job failed', { 
        userId: req.user?.id, 
        error: error.message,
        jobId: req.params.jobId
      });
      next(error);
    }
  },
  
  /**
   * Get user's recent submissions
   * @route GET /api/submissions/user
   */
  async getUserSubmissions(req: AuthRequest, res: Response, next: NextFunction) {
    try {
      const userId = req.user.id;
      const { page = 1, limit = 10, challengeId } = req.query;
      
      const submissions = await submissionService.getUserSubmissions(
        userId,
        {
          page: Number(page),
          limit: Number(limit),
          challengeId: challengeId as string
        }
      );
      
      res.status(200).json(submissions);
    } catch (error) {
      logger.error('Get user submissions failed', { 
        userId: req.user?.id, 
        error: error.message
      });
      next(error);
    }
  }
};
```

### 4.3 Submission Service Module

The Submission Service manages code submissions, test execution, and result processing:

```typescript
// backend/src/services/submission.service.ts
import { prisma } from '../lib/prisma';
import { redis } from '../lib/redis';
import { logger } from '../lib/logger';
import { NotFoundError, BadRequestError, ForbiddenError } from '../lib/errors';
import { codeExecutorService } from './code-executor.service';
import { aiFeedbackService } from './ai-feedback.service';
import { 
  CreateSubmissionDto, 
  SubmissionResultDto,
  SubmissionDetailDto,
  SubmissionFeedbackDto,
  SubmissionListDto,
  SubmissionFilters
} from '../dto/submission.dto';

export class SubmissionService {
  /**
   * Submit code for a challenge
   * @param submissionData Submission data including code and challenge ID
   * @returns Submission result with test results
   */
  async submitCode(submissionData: CreateSubmissionDto): Promise<SubmissionResultDto> {
    const { userId, challengeId, code, language } = submissionData;
    
    // Verify challenge exists
    const challenge = await prisma.challenge.findUnique({
      where: { id: challengeId },
      select: {
        id: true,
        testCases: true,
        isPublic: true,
        createdById: true
      }
    });
    
    if (!challenge) {
      throw new NotFoundError('Challenge not found');
    }
    
    // Check if challenge is public or user is creator/admin
    if (!challenge.isPublic && userId !== challenge.createdById) {
      // Check if user is admin
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { role: true }
      });
      
      if (!user || user.role !== 'ADMIN') {
        throw new ForbiddenError('You do not have permission to access this challenge');
      }
    }
    
    // Create submission record with pending status
    const submission = await prisma.submission.create({
      data: {
        userId,
        challengeId,
        codeSubmitted: code,
        language,
        status: 'PENDING'
      }
    });
    
    try {
      // Apply rate limiting for code execution
      const rateLimitKey = `ratelimit:code-execution:${userId}`;
      const currentRequests = await redis.incr(rateLimitKey);
      
      // Set expiry if this is the first request in the window
      if (currentRequests === 1) {
        await redis.expire(rateLimitKey, 60); // 1 minute window
      }
      
      // Check if rate limit exceeded (10 executions per minute)
      if (currentRequests > 10) {
        throw new BadRequestError('Rate limit exceeded. Please try again later.');
      }
      
      // Execute tests in secure environment
      const executionResult = await codeExecutorService.executeCode({
        code,
        language,
        testCases: challenge.testCases,
        timeout: 10000 // 10 seconds timeout
      });
      
      // Update submission with results
      const updatedSubmission = await prisma.submission.update({
        where: { id: submission.id },
        data: {
          status: executionResult.status === 'passed' ? 'PASSED' : 'FAILED',
          testResults: executionResult.testResults,
          executionTime: executionResult.executionTime,
          memoryUsed: executionResult.memoryUsed,
          score: executionResult.score
        }
      });
      
      // Update user progress
      await this.updateProgress(
        userId, 
        challengeId, 
        submission.id, 
        executionResult.status === 'passed'
      );
      
      // If tests pass, generate AI feedback asynchronously
      if (executionResult.status === 'passed') {
        // Queue feedback generation
        const jobId = await aiFeedbackService.generateFeedback({
          submissionId: submission.id,
          userId,
          code,
          language,
          challengeId
        });
        
        logger.info('Feedback generation queued', { 
          submissionId: submission.id, 
          jobId
        });
      }
      
      // Log submission result
      logger.info('Submission processed', { 
        submissionId: submission.id, 
        userId,
        challengeId,
        status: updatedSubmission.status,
        executionTime: executionResult.executionTime
      });
      
      return {
        id: updatedSubmission.id,
        status: updatedSubmission.status,
        testResults: executionResult.testResults,
        executionTime: executionResult.executionTime,
        memoryUsed: executionResult.memoryUsed,
        score: executionResult.score,
        feedback: null, // Will be fetched separately when ready
        feedbackStatus: executionResult.status === 'passed' ? 'pending' : null
      };
    } catch (error) {
      // Handle execution errors
      await prisma.submission.update({
        where: { id: submission.id },
        data: {
          status: 'ERROR',
          testResults: { error: error.message }
        }
      });
      
      logger.error('Submission execution error', { 
        submissionId: submission.id, 
        error: error.message,
        userId,
        challengeId
      });
      
      throw new Error(`Error executing code: ${error.message}`);
    }
  }
  
  /**
   * Get submission details
   * @param id Submission ID
   * @param userId User ID requesting the submission
   * @returns Submission details with test results
   * @throws NotFoundError if submission not found
   * @throws ForbiddenError if user doesn't have permission
   */
  async getSubmission(id: string, userId: string): Promise<SubmissionDetailDto> {
    // Get submission with challenge and user data
    const submission = await prisma.submission.findUnique({
      where: { id },
      include: {
        challenge: {
          select: {
            id: true,
            title: true,
            difficulty: true,
            category: true,
            createdById: true
          }
        },
        user: {
          select: {
            id: true,
            name: true,
            role: true
          }
        },
        feedback: true
      }
    });
    
    if (!submission) {
      throw new NotFoundError('Submission not found');
    }
    
    // Check permissions (owner, challenge creator, or admin)
    if (submission.userId !== userId && submission.challenge.createdById !== userId) {
      // Check if user is admin
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { role: true }
      });
      
      if (!user || user.role !== 'ADMIN') {
        throw new ForbiddenError('You do not have permission to access this submission');
      }
    }
    
    // Check if feedback is being generated
    let feedbackStatus: 'pending' | 'ready' | 'error' | null = null;
    
    if (submission.status === 'PASSED') {
      if (submission.feedback) {
        feedbackStatus = 'ready';
      } else {
        // Check if feedback is in progress
        const pendingKey = `feedback:pending:${submission.id}`;
        const errorKey = `feedback:error:${submission.id}`;
        
        const isPending = await redis.exists(pendingKey);
        const hasError = await redis.exists(errorKey);
        
        if (isPending) {
          feedbackStatus = 'pending';
        } else if (hasError) {
          feedbackStatus = 'error';
        } else {
          // No pending or error status, and no feedback - start generation
          feedbackStatus = 'pending';
          
          // Queue feedback generation
          aiFeedbackService.generateFeedback({
            submissionId: submission.id,
            userId: submission.userId,
            code: submission.codeSubmitted,
            language: submission.language,
            challengeId: submission.challengeId
          });
          
          // Mark as pending
          await redis.set(pendingKey, '1', 'EX', 300); // 5 minutes expiry
        }
      }
    }
    
    return {
      id: submission.id,
      userId: submission.userId,
      userName: submission.user.name,
      challengeId: submission.challengeId,
      challengeTitle: submission.challenge.title,
      challengeDifficulty: submission.challenge.difficulty,
      challengeCategory: submission.challenge.category,
      codeSubmitted: submission.codeSubmitted,
      language: submission.language,
      status: submission.status,
      testResults: submission.testResults,
      executionTime: submission.executionTime,
      memoryUsed: submission.memoryUsed,
      score: submission.score,
      createdAt: submission.createdAt,
      feedback: submission.feedback ? {
        id: submission.feedback.id,
        strengths: submission.feedback.strengths,
        improvements: submission.feedback.improvements,
        suggestions: submission.feedback.suggestions,
        conceptualErrors: submission.feedback.conceptualErrors,
        score: submission.feedback.score,
        source: submission.feedback.source,
        createdAt: submission.feedback.createdAt
      } : null,
      feedbackStatus
    };
  }
  
  /**
   * Get submission feedback
   * @param id Submission ID
   * @param userId User ID requesting the feedback
   * @returns Submission feedback
   * @throws NotFoundError if submission or feedback not found
   * @throws ForbiddenError if user doesn't have permission
   */
  async getSubmissionFeedback(id: string, userId: string): Promise<SubmissionFeedbackDto> {
    // Get submission with feedback
    const submission = await prisma.submission.findUnique({
      where: { id },
      include: {
        feedback: true,
        challenge: {
          select: {
            createdById: true
          }
        },
        user: {
          select: {
            id: true,
            name: true
          }
        }
      }
    });
    
    if (!submission) {
      throw new NotFoundError('Submission not found');
    }
    
    // Check permissions (owner, challenge creator, or admin)
    if (submission.userId !== userId && submission.challenge.createdById !== userId) {
      // Check if user is admin
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { role: true }
      });
      
      if (!user || user.role !== 'ADMIN') {
        throw new ForbiddenError('You do not have permission to access this feedback');
      }
    }
    
    // Check if feedback exists
    if (!submission.feedback) {
      // Check if generation is in progress
      const pendingKey = `feedback:pending:${submission.id}`;
      const errorKey = `feedback:error:${submission.id}`;
      
      const isPending = await redis.exists(pendingKey);
      const hasError = await redis.exists(errorKey);
      
      if (isPending) {
        return {
          status: 'pending',
          message: 'Feedback is being generated'
        };
      } else if (hasError) {
        const errorMessage = await redis.get(errorKey);
        return {
          status: 'error',
          message: errorMessage || 'An error occurred while generating feedback'
        };
      } else {
        // No pending or error status, and no feedback - start generation
        aiFeedbackService.generateFeedback({
          submissionId: submission.id,
          userId: submission.userId,
          code: submission.codeSubmitted,
          language: submission.language,
          challengeId: submission.challengeId
        });
        
        // Mark as pending
        await redis.set(pendingKey, '1', 'EX', 300); // 5 minutes expiry
        
        return {
          status: 'pending',
          message: 'Feedback generation has been started'
        };
      }
    }
    
    // Return feedback
    return {
      status: 'ready',
      feedback: {
        id: submission.feedback.id,
        submissionId: submission.id,
        strengths: submission.feedback.strengths,
        improvements: submission.feedback.improvements,
        suggestions: submission.feedback.suggestions,
        conceptualErrors: submission.feedback.conceptualErrors,
        score: submission.feedback.score,
        tokenCount: submission.feedback.tokenCount,
        source: submission.feedback.source,
        modelUsed: submission.feedback.modelUsed,
        processingTime: submission.feedback.processingTime,
        createdAt: submission.feedback.createdAt
      }
    };
  }
  
  /**
   * Regenerate feedback for a submission
   * @param id Submission ID
   * @param userId User ID requesting regeneration
   * @returns Job ID for tracking the regeneration
   * @throws NotFoundError if submission not found
   * @throws ForbiddenError if user doesn't have permission
   */
  async regenerateFeedback(id: string, userId: string): Promise<{jobId: string}> {
    // Get submission data
    const submission = await prisma.submission.findUnique({
      where: { id },
      select: {
        id: true,
        userId: true,
        challengeId: true,
        codeSubmitted: true,
        language: true,
        status: true,
        user: {
          select: {
            role: true
          }
        }
      }
    });
    
    if (!submission) {
      throw new NotFoundError('Submission not found');
    }
    
    // Check permissions (owner or admin)
    if (submission.userId !== userId) {
      // Check if user is admin
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { role: true }
      });
      
      if (!user || user.role !== 'ADMIN') {
        throw new ForbiddenError('You do not have permission to regenerate feedback');
      }
    }
    
    // Check if submission passed tests
    if (submission.status !== 'PASSED') {
      throw new BadRequestError('Cannot generate feedback for failed submissions');
    }
    
    // Check if user has premium subscription unless they're admin
    if (submission.userId === userId && submission.user.role !== 'ADMIN') {
      const canRegenerateKey = `feedback:regenerate:${userId}:limit`;
      const currentCount = await redis.incr(canRegenerateKey);
      
      // First time? Set expiry for 24 hours
      if (currentCount === 1) {
        await redis.expire(canRegenerateKey, 60 * 60 * 24);
      }
      
      // Check if limit reached (3 per day for standard, unlimited for premium)
      if (currentCount > 3) {
        throw new BadRequestError('Daily regeneration limit reached');
      }
    }
    
    // Delete existing feedback if any
    await prisma.aIFeedback.deleteMany({
      where: { submissionId: id }
    });
    
    // Clear any pending or error status
    await redis.del(`feedback:pending:${id}`);
    await redis.del(`feedback:error:${id}`);
    
    // Queue feedback generation
    const jobId = await aiFeedbackService.generateFeedback({
      submissionId: id,
      userId: submission.userId,
      code: submission.codeSubmitted,
      language: submission.language,
      challengeId: submission.challengeId,
      urgent: true // Prioritize regeneration requests
    });
    
    // Mark as pending
    await redis.set(`feedback:pending:${id}`, '1', 'EX', 300); // 5 minutes expiry
    
    // Log regeneration request
    logger.info('Feedback regeneration requested', {
      submissionId: id,
      userId,
      jobId
    });
    
    return { jobId };
  }
  
  /**
   * Check status of a feedback generation job
   * @param jobId Job ID from feedback generation
   * @param userId User ID checking the job
   * @returns Job status and feedback if completed
   */
  async checkFeedbackJob(jobId: string, userId: string): Promise<any> {
    try {
      // Check job status
      const status = await aiFeedbackService.checkFeedbackJob(jobId);
      
      // If job is completed and has a result with a submission ID
      if (status.status === 'completed' && status.result && status.result.submissionId) {
        // Get the feedback for the submission
        const submissionId = status.result.submissionId;
        
        // Get submission and feedback
        const submission = await prisma.submission.findUnique({
          where: { id: submissionId },
          include: {
            feedback: true
          }
        });
        
        // Check if user has permission to see this feedback
        if (submission.userId !== userId) {
          // Check if user is admin or challenge creator
          const user = await prisma.user.findUnique({
            where: { id: userId },
            select: { role: true }
          });
          
          const challenge = await prisma.challenge.findUnique({
            where: { id: submission.challengeId },
            select: { createdById: true }
          });
          
          if (
            (!user || user.role !== 'ADMIN') && 
            challenge.createdById !== userId
          ) {
            throw new ForbiddenError('You do not have permission to access this feedback');
          }
        }
        
        // Return feedback if available
        if (submission.feedback) {
          return {
            status: 'completed',
            feedback: {
              id: submission.feedback.id,
              submissionId: submission.id,
              strengths: submission.feedback.strengths,
              improvements: submission.feedback.improvements,
              suggestions: submission.feedback.suggestions,
              conceptualErrors: submission.feedback.conceptualErrors,
              score: submission.feedback.score,
              tokenCount: submission.feedback.tokenCount,
              source: submission.feedback.source,
              modelUsed: submission.feedback.modelUsed,
              processingTime: submission.feedback.processingTime,
              createdAt: submission.feedback.createdAt
            }
          };
        }
      }
      
      // Return job status
      return status;
    } catch (error) {
      logger.error('Error checking feedback job', {
        jobId,
        userId,
        error: error.message
      });
      
      throw error;
    }
  }
  
  /**
   * Get user's submissions with pagination
   * @param userId User ID
   * @param filters Pagination and filtering options
   * @returns Paginated list of user submissions
   */
  async getUserSubmissions(userId: string, filters: SubmissionFilters): Promise<SubmissionListDto> {
    const { page = 1, limit = 10, challengeId } = filters;
    
    // Build where clause
    const where: any = { userId };
    
    if (challengeId) {
      where.challengeId = challengeId;
    }
    
    // Count total submissions
    const total = await prisma.submission.count({ where });
    
    // Get paginated submissions
    const submissions = await prisma.submission.findMany({
      where,
      include: {
        challenge: {
          select: {
            id: true,
            title: true,
            difficulty: true,
            category: true
          }
        }
      },
      orderBy: { createdAt: 'desc' },
      skip: (page - 1) * limit,
      take: limit
    });
    
    return {
      submissions: submissions.map(sub => ({
        id: sub.id,
        challengeId: sub.challengeId,
        challengeTitle: sub.challenge.title,
        challengeDifficulty: sub.challenge.difficulty,
        challengeCategory: sub.challenge.category,
        language: sub.language,
        status: sub.status,
        score: sub.score,
        executionTime: sub.executionTime,
        createdAt: sub.createdAt,
        hasFeedback: sub.status === 'PASSED' // Simplified check - could be more precise
      })),
      pagination: {
        page,
        limit,
        total,
        pages: Math.ceil(total / limit)
      }
    };
  }
  
  /**
   * Update user progress for a challenge
   * @param userId User ID
   * @param challengeId Challenge ID
   * @param submissionId Submission ID
   * @param passed Whether the submission passed all tests
   * @private
   */
  private async updateProgress(
    userId: string, 
    challengeId: string, 
    submissionId: string, 
    passed: boolean
  ): Promise<void> {
    try {
      // Get existing progress
      const existingProgress = await prisma.progress.findUnique({
        where: {
          userId_challengeId: {
            userId,
            challengeId
          }
        }
      });
      
      if (!existingProgress) {
        // Create new progress record
        await prisma.progress.create({
          data: {
            userId,
            challengeId,
            status: passed ? 'COMPLETED' : 'IN_PROGRESS',
            bestSubmissionId: passed ? submissionId : null,
            attemptsCount: 1,
            firstAttemptedAt: new Date(),
            completedAt: passed ? new Date() : null
          }
        });
      } else {
        // Update existing progress
        await prisma.progress.update({
          where: {
            userId_challengeId: {
              userId,
              challengeId
            }
          },
          data: {
            status: passed ? 'COMPLETED' : existingProgress.status,
            bestSubmissionId: passed ? submissionId : existingProgress.bestSubmissionId,
            attemptsCount: { increment: 1 },
            completedAt: passed && !existingProgress.completedAt ? new Date() : undefined
          }
        });
      }
      
      // Invalidate user progress cache
      const progressCacheKey = `user:${userId}:progress`;
      await redis.del(progressCacheKey);
    } catch (error) {
      logger.error('Failed to update progress', {
        userId,
        challengeId,
        error: error.message
      });
      // Non-critical operation, don't throw error
    }
  }
}

export const submissionService = new SubmissionService();
```

### 4.4 Analytics & Reporting Module

The Analytics module collects, analyzes, and visualizes user activity and performance data:

```typescript
// backend/src/services/analytics.service.ts
import { prisma } from '../lib/prisma';
import { redis } from '../lib/redis';
import { NotFoundError, ForbiddenError } from '../lib/errors';
import { logger } from '../lib/logger';
import {
  UserAnalyticsDto,
  InstructorAnalyticsDto,
  ChallengeAnalyticsDto
} from '../dto/analytics.dto';

export class AnalyticsService {
  /**
   * Get comprehensive analytics for a user
   * @param userId User ID
   * @returns User analytics data
   * @throws NotFoundError if user not found
   */
  async getUserAnalytics(userId: string): Promise<UserAnalyticsDto> {
    // Check cache first
    const cacheKey = `analytics:user:${userId}`;
    const cachedData = await redis.get(cacheKey);
    
    if (cachedData) {
      return JSON.parse(cachedData);
    }
    
    // Verify user exists
    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: { id: true }
    });
    
    if (!user) {
      throw new NotFoundError('User not found');
    }
    
    // Get user challenge progress
    const progressStats = await prisma.progress.groupBy({
      by: ['status'],
      where: { userId },
      _count: true
    });
    
    // Map progress stats to a more usable format
    const progressSummary = {
      completed: 0,
      inProgress: 0,
      notStarted: 0
    };
    
    progressStats.forEach(stat => {
      if (stat.status === 'COMPLETED') {
        progressSummary.completed = stat._count;
      } else if (stat.status === 'IN_PROGRESS') {
        progressSummary.inProgress = stat._count;
      } else if (stat.status === 'NOT_STARTED') {
        progressSummary.notStarted = stat._count;
      }
    });
    
    // Get recent submissions with more details
    const recentSubmissions = await prisma.submission.findMany({
      where: { userId },
      orderBy: { createdAt: 'desc' },
      take: 10,
      include: {
        challenge: {
          select: {
            id: true,
            title: true,
            difficulty: true,
            category: true
          }
        },
        feedback: {
          select: {
            id: true,
            score: true
          }
        }
      }
    });
    
    // Get category completion stats
    const categoryStats = await prisma.$queryRaw`
      SELECT c.category, 
             COUNT(DISTINCT c.id) as total, 
             COUNT(DISTINCT CASE WHEN p.status = 'COMPLETED' THEN c.id ELSE NULL END) as completed
      FROM "Challenge" c
      LEFT JOIN "Progress" p ON c.id = p."challengeId" AND p."userId" = ${userId}
      WHERE c."isPublic" = true
      GROUP BY c.category
      ORDER BY c.category
    `;
    
    // Get difficulty distribution
    const difficultyStats = await prisma.$queryRaw`
      SELECT c.difficulty, 
             COUNT(DISTINCT c.id) as total, 
             COUNT(DISTINCT CASE WHEN p.status = 'COMPLETED' THEN c.id ELSE NULL END) as completed
      FROM "Challenge" c
      LEFT JOIN "Progress" p ON c.id = p."challengeId" AND p."userId" = ${userId}
      WHERE c."isPublic" = true
      GROUP BY c.difficulty
      ORDER BY CASE 
        WHEN c.difficulty = 'BEGINNER' THEN 1
        WHEN c.difficulty = 'INTERMEDIATE' THEN 2
        WHEN c.difficulty = 'ADVANCED' THEN 3
        WHEN c.difficulty = 'EXPERT' THEN 4
        ELSE 5
      END
    `;
    
    // Get skill progression over time (weekly)
    const skillProgression = await prisma.$queryRaw`
      SELECT DATE_TRUNC('week', s."createdAt") as week,
             COUNT(*) as submissions,
             COUNT(CASE WHEN s.status = 'PASSED' THEN 1 ELSE NULL END) as passed,
             AVG(s.score) as average_score
      FROM "Submission" s
      WHERE s."userId" = ${userId}
        AND s."createdAt" > NOW() - INTERVAL '6 months'
      GROUP BY DATE_TRUNC('week', s."createdAt")
      ORDER BY week ASC
    `;
    
    // Get average completion time by difficulty
    const completionTime = await prisma.$queryRaw`
      SELECT c.difficulty,
             AVG(EXTRACT(EPOCH FROM (p."completedAt" - p."firstAttemptedAt"))) as avg_seconds
      FROM "Progress" p
      JOIN "Challenge" c ON p."challengeId" = c.id
      WHERE p."userId" = ${userId}
        AND p.status = 'COMPLETED'
        AND p."completedAt" IS NOT NULL
        AND p."firstAttemptedAt" IS NOT NULL
      GROUP BY c.difficulty
      ORDER BY CASE 
        WHEN c.difficulty = 'BEGINNER' THEN 1
        WHEN c.difficulty = 'INTERMEDIATE' THEN 2
        WHEN c.difficulty = 'ADVANCED' THEN 3
        WHEN c.difficulty = 'EXPERT' THEN 4
        ELSE 5
      END
    `;
    
    // Get language usage
    const languageUsage = await prisma.submission.groupBy({
      by: ['language'],
      where: { userId },
      _count: true,
      orderBy: {
        _count: {
          language: 'desc'
        }
      }
    });
    
    // Calculate submission success rate
    const submissionStats = await prisma.submission.groupBy({
      by: ['status'],
      where: { userId },
      _count: true
    });
    
    const submissionTotal = submissionStats.reduce((sum, stat) => sum + stat._count, 0);
    const passedCount = submissionStats.find(s => s.status === 'PASSED')?._count || 0;
    const successRate = submissionTotal > 0 ? (passedCount / submissionTotal) * 100 : 0;
    
    // Structure the analytics data
    const analytics: UserAnalyticsDto = {
      progressSummary,
      recentActivity: recentSubmissions.map(sub => ({
        id: sub.id,
        challengeId: sub.challengeId,
        challengeTitle: sub.challenge.title,
        difficulty: sub.challenge.difficulty,
        category: sub.challenge.category,
        status: sub.status,
        score: sub.score,
        feedbackScore: sub.feedback?.score,
        createdAt: sub.createdAt
      })),
      categoryCompletion: categoryStats.map(cat => ({
        category: cat.category,
        total: Number(cat.total),
        completed: Number(cat.completed),
        percentage: cat.total > 0 ? (Number(cat.completed) / Number(cat.total)) * 100 : 0
      })),
      difficultyCompletion: difficultyStats.map(diff => ({
        difficulty: diff.difficulty,
        total: Number(diff.total),
        completed: Number(diff.completed),
        percentage: diff.total > 0 ? (Number(diff.completed) / Number(diff.total)) * 100 : 0
      })),
      skillProgression: skillProgression.map(skill => ({
        week: skill.week,
        submissions: Number(skill.submissions),
        passed: Number(skill.passed),
        averageScore: Number(skill.average_score) || 0
      })),
      completionTime: completionTime.map(ct => ({
        difficulty: ct.difficulty,
        averageSeconds: Number(ct.avg_seconds) || 0
      })),
      languageUsage: languageUsage.map(lang => ({
        language: lang.language,
        count: lang._count
      })),
      submissionStats: {
        total: submissionTotal,
        passed: passedCount,
        successRate
      }
    };
    
    // Cache for 30 minutes
    await redis.set(cacheKey, JSON.stringify(analytics), 'EX', 30 * 60);
    
    return analytics;
  }
  
  /**
   * Get analytics for an instructor's challenges
   * @param instructorId Instructor user ID
   * @returns Instructor analytics data
   * @throws NotFoundError if user not found or not an instructor
   */
  async getInstructorAnalytics(instructorId: string): Promise<InstructorAnalyticsDto> {
    // Check cache first
    const cacheKey = `analytics:instructor:${instructorId}`;
    const cachedData = await redis.get(cacheKey);
    
    if (cachedData) {
      return JSON.parse(cachedData);
    }
    
    // Verify user is an instructor
    const user = await prisma.user.findUnique({
      where: { id: instructorId },
      select: { id: true, role: true }
    });
    
    if (!user) {
      throw new NotFoundError('User not found');
    }
    
    if (user.role !== 'INSTRUCTOR' && user.role !== 'ADMIN') {
      throw new ForbiddenError('User is not an instructor');
    }
    
    // Get instructor-created challenges
    const challenges = await prisma.challenge.findMany({
      where: { createdById: instructorId },
      select: { id: true }
    });
    
    const challengeIds = challenges.map(c => c.id);
    
    if (challengeIds.length === 0) {
      // No challenges yet, return empty data
      return {
        challengeCount: 0,
        submissionStats: {
          total: 0,
          passed: 0,
          failed: 0,
          error: 0
        },
        challengeCompletion: [],
        difficultyDistribution: {
          beginner: 0,
          intermediate: 0,
          advanced: 0,
          expert: 0
        },
        recentSubmissions: [],
        popularChallenges: [],
        challengeTrends: []
      };
    }
    
    // Get submission stats for instructor challenges
    const submissionStats = await prisma.submission.groupBy({
      by: ['status'],
      where: {
        challengeId: { in: challengeIds }
      },
      _count: true
    });
    
    // Structure submission stats
    const submissionCounts = {
      total: 0,
      passed: 0,
      failed: 0,
      error: 0
    };
    
    submissionStats.forEach(stat => {
      if (stat.status === 'PASSED') {
        submissionCounts.passed = stat._count;
      } else if (stat.status === 'FAILED') {
        submissionCounts.failed = stat._count;
      } else if (stat.status === 'ERROR') {
        submissionCounts.error = stat._count;
      }
      submissionCounts.total += stat._count;
    });
    
    // Get completion rate by challenge
    const challengeCompletion = await prisma.$queryRaw`
      SELECT c.id, c.title, c.difficulty,
             COUNT(DISTINCT s."userId") as attempt_count,
             COUNT(DISTINCT CASE WHEN p.status = 'COMPLETED' THEN p."userId" ELSE NULL END) as completion_count
      FROM "Challenge" c
      LEFT JOIN "Submission" s ON c.id = s."challengeId"
      LEFT JOIN "Progress" p ON c.id = p."challengeId"
      WHERE c."createdById" = ${instructorId}
      GROUP BY c.id, c.title, c.difficulty
      ORDER BY attempt_count DESC
    `;
    
    // Get difficulty distribution
    const difficultyDistribution = await prisma.challenge.groupBy({
      by: ['difficulty'],
      where: { createdById: instructorId },
      _count: true
    });
    
    // Structure difficulty distribution
    const difficultyDist = {
      beginner: 0,
      intermediate: 0,
      advanced: 0,
      expert: 0
    };
    
    difficultyDistribution.forEach(diff => {
      const key = diff.difficulty.toLowerCase();
      difficultyDist[key] = diff._count;
    });
    
    // Get recent submissions
    const recentSubmissions = await prisma.submission.findMany({
      where: {
        challengeId: { in: challengeIds }
      },
      orderBy: { createdAt: 'desc' },
      take: 10,
      include: {
        user: {
          select: {
            id: true,
            name: true
          }
        },
        challenge: {
          select: {
            id: true,
            title: true,
            difficulty: true
          }
        }
      }
    });
    
    // Get popular challenges (most attempted)
    const popularChallenges = await prisma.$queryRaw`
      SELECT c.id, c.title, c.difficulty, 
             COUNT(DISTINCT s."userId") as unique_users,
             COUNT(s.id) as submission_count
      FROM "Challenge" c
      JOIN "Submission" s ON c.id = s."challengeId"
      WHERE c."createdById" = ${instructorId}
      GROUP BY c.id, c.title, c.difficulty
      ORDER BY unique_users DESC, submission_count DESC
      LIMIT 5
    `;
    
    // Get submission trends over time
    const challengeTrends = await prisma.$queryRaw`
      SELECT DATE_TRUNC('week', s."createdAt") as week,
             COUNT(*) as submission_count,
             COUNT(DISTINCT s."userId") as unique_users,
             COUNT(CASE WHEN s.status = 'PASSED' THEN 1 ELSE NULL END) as passed_count
      FROM "Submission" s
      JOIN "Challenge" c ON s."challengeId" = c.id
      WHERE c."createdById" = ${instructorId}
        AND s."createdAt" > NOW() - INTERVAL '3 months'
      GROUP BY DATE_TRUNC('week', s."createdAt")
      ORDER BY week ASC
    `;
    
    // Structure the analytics data
    const analytics: InstructorAnalyticsDto = {
      challengeCount: challenges.length,
      submissionStats: submissionCounts,
      challengeCompletion: challengeCompletion.map(c => ({
        id: c.id,
        title: c.title,
        difficulty: c.difficulty,
        attemptCount: Number(c.attempt_count),
        completionCount: Number(c.completion_count),
        completionRate: c.attempt_count > 0 
          ? (Number(c.completion_count) / Number(c.attempt_count)) * 100 
          : 0
      })),
      difficultyDistribution: difficultyDist,
      recentSubmissions: recentSubmissions.map(sub => ({
        id: sub.id,
        userId: sub.userId,
        userName: sub.user.name,
        challengeId: sub.challengeId,
        challengeTitle: sub.challenge.title,
        difficulty: sub.challenge.difficulty,
        status: sub.status,
        score: sub.score,
        createdAt: sub.createdAt
      })),
      popularChallenges: popularChallenges.map(pc => ({
        id: pc.id,
        title: pc.title,
        difficulty: pc.difficulty,
        uniqueUsers: Number(pc.unique_users),
        submissionCount: Number(pc.submission_count)
      })),
      challengeTrends: challengeTrends.map(trend => ({
        week: trend.week,
        submissionCount: Number(trend.submission_count),
        uniqueUsers: Number(trend.unique_users),
        passedCount: Number(trend.passed_count),
        passRate: trend.submission_count > 0 
          ? (Number(trend.passed_count) / Number(trend.submission_count)) * 100 
          : 0
      }))
    };
    
    // Cache for 30 minutes
    await redis.set(cacheKey, JSON.stringify(analytics), 'EX', 30 * 60);
    
    return analytics;
  }
  
  /**
   * Get detailed analytics for a specific challenge
   * @param challengeId Challenge ID
   * @param userId User ID requesting the analytics
   * @returns Challenge analytics data
   * @throws NotFoundError if challenge not found
   * @throws ForbiddenError if user doesn't have permission
   */
  async getChallengeAnalytics(challengeId: string, userId: string): Promise<ChallengeAnalyticsDto> {
    // Check cache first
    const cacheKey = `analytics:challenge:${challengeId}`;
    const cachedData = await redis.get(cacheKey);
    
    if (cachedData) {
      return JSON.parse(cachedData);
    }
    
    // Get challenge and check permissions
    const challenge = await prisma.challenge.findUnique({
      where: { id: challengeId },
      select: {
        id: true,
        title: true,
        difficulty: true,
        category: true,
        createdById: true,
        createdAt: true
      }
    });
    
    if (!challenge) {
      throw new NotFoundError('Challenge not found');
    }
    
    // Check if user is challenge creator or admin
    if (challenge.createdById !== userId) {
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { role: true }
      });
      
      if (!user || user.role !== 'ADMIN') {
        throw new ForbiddenError('You do not have permission to access these analytics');
      }
    }
    
    // Get submission statistics
    const submissionStats = await prisma.submission.groupBy({
      by: ['status'],
      where: { challengeId },
      _count: true
    });
    
    // Structure submission stats
    const submissions = {
      total: 0,
      passed: 0,
      failed: 0,
      error: 0
    };
    
    submissionStats.forEach(stat => {
      if (stat.status === 'PASSED') {
        submissions.passed = stat._count;
      } else if (stat.status === 'FAILED') {
        submissions.failed = stat._count;
      } else if (stat.status === 'ERROR') {
        submissions.error = stat._count;
      }
      submissions.total += stat._count;
    });
    
    // Calculate success rate
    const successRate = submissions.total > 0 
      ? (submissions.passed / submissions.total) * 100 
      : 0;
    
    // Get user completion stats
    const userStats = await prisma.$queryRaw`
      SELECT COUNT(DISTINCT s."userId") as attempt_count,
             COUNT(DISTINCT CASE WHEN p.status = 'COMPLETED' THEN p."userId" ELSE NULL END) as completion_count,
             AVG(s."executionTime") as avg_execution_time,
             MIN(s."executionTime") as min_execution_time,
             MAX(s."executionTime") as max_execution_time
      FROM "Submission" s
      LEFT JOIN "Progress" p ON s."challengeId" = p."challengeId" AND s."userId" = p."userId"
      WHERE s."challengeId" = ${challengeId}
    `;
    
    // Get average attempts to completion
    const attemptsToCompletion = await prisma.$queryRaw`
      SELECT AVG(p."attemptsCount") as avg_attempts
      FROM "Progress" p
      WHERE p."challengeId" = ${challengeId} AND p.status = 'COMPLETED'
    `;
    
    // Get submission trends over time
    const submissionTrends = await prisma.$queryRaw`
      SELECT DATE_TRUNC('day', s."createdAt") as day,
             COUNT(*) as submission_count,
             COUNT(DISTINCT s."userId") as unique_users,
             COUNT(CASE WHEN s.status = 'PASSED' THEN 1 ELSE NULL END) as passed_count
      FROM "Submission" s
      WHERE s."challengeId" = ${challengeId}
        AND s."createdAt" > NOW() - INTERVAL '30 days'
      GROUP BY DATE_TRUNC('day', s."createdAt")
      ORDER BY day ASC
    `;
    
    // Get language distribution
    const languageDistribution = await prisma.submission.groupBy({
      by: ['language'],
      where: { challengeId },
      _count: true,
      orderBy: {
        _count: {
          language: 'desc'
        }
      }
    });
    
    // Get common errors
    const commonErrors = await prisma.$queryRaw`
      SELECT s."testResults"->>'error' as error_message,
             COUNT(*) as occurrence_count
      FROM "Submission" s
      WHERE s."challengeId" = ${challengeId}
        AND s.status = 'ERROR'
        AND s."testResults"->>'error' IS NOT NULL
      GROUP BY s."testResults"->>'error'
      ORDER BY occurrence_count DESC
      LIMIT 5
    `;
    
    // Get common failing test cases
    const failingTests = await prisma.$queryRaw`
      WITH test_results AS (
        SELECT s.id, jsonb_array_elements(s."testResults") as test_case
        FROM "Submission" s
        WHERE s."challengeId" = ${challengeId}
          AND s.status = 'FAILED'
      )
      SELECT test_case->>'description' as test_description,
             COUNT(*) as failure_count
      FROM test_results
      WHERE test_case->>'passed' = 'false'
      GROUP BY test_description
      ORDER BY failure_count DESC
      LIMIT 5
    `;
    
    // Get recent submissions
    const recentSubmissions = await prisma.submission.findMany({
      where: { challengeId },
      orderBy: { createdAt: 'desc' },
      take: 10,
      include: {
        user: {
          select: {
            id: true,
            name: true
          }
        }
      }
    });
    
    // Structure the analytics data
    const analytics: ChallengeAnalyticsDto = {
      challenge: {
        id: challenge.id,
        title: challenge.title,
        difficulty: challenge.difficulty,
        category: challenge.category,
        createdAt: challenge.createdAt
      },
      submissionStats: {
        ...submissions,
        successRate
      },
      userStats: {
        uniqueAttempts: Number(userStats[0]?.attempt_count) || 0,
        uniqueCompletions: Number(userStats[0]?.completion_count) || 0,
        completionRate: userStats[0]?.attempt_count > 0 
          ? (Number(userStats[0]?.completion_count) / Number(userStats[0]?.attempt_count)) * 100 
          : 0,
        averageAttemptsToCompletion: Number(attemptsToCompletion[0]?.avg_attempts) || 0
      },
      performanceStats: {
        averageExecutionTime: Number(userStats[0]?.avg_execution_time) || 0,
        minExecutionTime: Number(userStats[0]?.min_execution_time) || 0,
        maxExecutionTime: Number(userStats[0]?.max_execution_time) || 0
      },
      submissionTrends: submissionTrends.map(trend => ({
        day: trend.day,
        submissionCount: Number(trend.submission_count),
        uniqueUsers: Number(trend.unique_users),
        passedCount: Number(trend.passed_count),
        passRate: trend.submission_count > 0 
          ? (Number(trend.passed_count) / Number(trend.submission_count)) * 100 
          : 0
      })),
      languageDistribution: languageDistribution.map(lang => ({
        language: lang.language,
        count: lang._count,
        percentage: submissions.total > 0 
          ? (lang._count / submissions.total) * 100 
          : 0
      })),
      commonErrors: commonErrors.map(err => ({
        errorMessage: err.error_message,
        occurrences: Number(err.occurrence_count)
      })),
      failingTests: failingTests.map(test => ({
        testDescription: test.test_description,
        failureCount: Number(test.failure_count)
      })),
      recentSubmissions: recentSubmissions.map(sub => ({
        id: sub.id,
        userId: sub.userId,
        userName: sub.user.name,
        status: sub.status,
        language: sub.language,
        score: sub.score,
        executionTime: sub.executionTime,
        createdAt: sub.createdAt
      }))
    };
    
    // Cache for 15 minutes
    await redis.set(cacheKey, JSON.stringify(analytics), 'EX', 15 * 60);
    
    return analytics;
  }
}
```

## 5. Database Architecture

### 5.1 Entity Relationship Diagram

```mermaid
erDiagram
    User ||--o{ Submission : creates
    User ||--o{ Progress : tracks
    User ||--o{ Challenge : authors
    User }|--o{ Enrollment : has
    Challenge ||--o{ Submission : receives
    Challenge ||--o{ Progress : tracks
    Challenge }|--o{ CourseChallenge : included_in
    Course ||--o{ CourseChallenge : contains
    Course ||--o{ Enrollment : has
    Submission ||--o{ Progress : updates
    Submission ||--o| AIFeedback : receives
    LearningPath ||--o{ LearningPathStep : contains
    LearningPathStep ||--o{ Challenge : references
    SkillTree ||--o{ SkillNode : contains
    SkillNode ||--o{ UserSkill : assessed_by
    User ||--o{ UserSkill : has
    
    User {
        UUID id PK
        String email UK
        String passwordHash
        String name
        Enum role
        String githubId UK
        String googleId UK
        String profileImage
        JSON settings
        Int totalTokensUsed
        DateTime createdAt
        DateTime updatedAt
    }
    
    Challenge {
        UUID id PK
        String title
        Text description
        Enum difficulty
        String category
        Text instructions
        Text starterCode
        JSON testCases
        Text solutionCode
        JSON hints
        String[] tags
        Boolean isPublic
        Int estimatedTime
        UUID createdById FK
        DateTime createdAt
        DateTime updatedAt
    }
    
    Submission {
        UUID id PK
        UUID userId FK
        UUID challengeId FK
        Text codeSubmitted
        String language
        Enum status
        JSON testResults
        Int executionTime
        Int memoryUsed
        Float score
        Vector embedding
        DateTime createdAt
    }
    
    Progress {
        UUID id PK
        UUID userId FK
        UUID challengeId FK
        Enum status
        UUID bestSubmissionId FK
        Int attemptsCount
        DateTime firstAttemptedAt
        DateTime completedAt
    }
    
    AIFeedback {
        UUID id PK
        UUID submissionId FK
        JSON strengths
        JSON improvements
        JSON suggestions
        JSON conceptualErrors
        Float score
        Int tokenCount
        String source
        String modelUsed
        Int processingTime
        DateTime createdAt
    }
    
    Course {
        UUID id PK
        String title
        Text description
        UUID instructorId FK
        String lmsId
        String lmsPlatform
        Boolean isActive
        DateTime createdAt
        DateTime updatedAt
    }
    
    CourseChallenge {
        UUID id PK
        UUID courseId FK
        UUID challengeId FK
        DateTime dueDate
        Float pointsPossible
        Boolean isRequired
        Int orderIndex
    }
    
    Enrollment {
        UUID id PK
        UUID userId FK
        UUID courseId FK
        Enum role
        String lmsUserId
        Boolean isActive
        DateTime createdAt
    }
    
    LearningPath {
        UUID id PK
        String title
        Text description
        Enum difficulty
        Int estimatedHours
        String[] skillsGained
        Boolean isPublic
    }
    
    LearningPathStep {
        UUID id PK
        UUID pathId FK
        UUID challengeId FK
        Int order
        Boolean isRequired
    }
    
    SkillTree {
        UUID id PK
        String name
        Text description
    }
    
    SkillNode {
        UUID id PK
        UUID treeId FK
        String name
        Text description
        Int level
        UUID[] prerequisites
        UUID[] challengeIds
    }
    
    UserSkill {
        UUID id PK
        UUID userId FK
        UUID skillNodeId FK
        Float proficiency
        DateTime lastDemonstrated
    }
    
    UsageLog {
        UUID id PK
        UUID userId FK
        String type
        UUID challengeId FK
        Int tokenCount
        DateTime timestamp
    }
```

### 5.2 Database Schema (Prisma)

```prisma
// prisma/schema.prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
  previewFeatures = ["fullTextSearch", "postgresqlExtensions", "multiSchema"]
}

model User {
  id            String      @id @default(uuid())
  email         String      @unique
  passwordHash  String?
  name          String
  role          UserRole    @default(STUDENT)
  githubId      String?     @unique
  googleId      String?     @unique
  profileImage  String?
  settings      Json?
  totalTokensUsed Int       @default(0)
  createdAt     DateTime    @default(now())
  updatedAt     DateTime    @updatedAt
  
  submissions   Submission[]
  progress      Progress[]
  enrollments   Enrollment[]
  challenges    Challenge[]
  userSkills    UserSkill[]
  usageLogs     UsageLog[]

  @@index([email])
  @@index([role])
}

model Challenge {
  id            String      @id @default(uuid())
  title         String
  description   String      @db.Text
  difficulty    Difficulty
  category      String
  instructions  String      @db.Text
  starterCode   String      @db.Text
  testCases     Json
  solutionCode  String      @db.Text
  hints         Json?
  learningOutcomes String[]
  tags          String[]
  estimatedTime Int?
  isPublic      Boolean     @default(true)
  createdById   String
  createdAt     DateTime    @default(now())
  updatedAt     DateTime    @updatedAt
  
  createdBy     User        @relation(fields: [createdById], references: [id])
  submissions   Submission[]
  progress      Progress[]
  courseChallenges CourseChallenge[]
  learningPathSteps LearningPathStep[]

  @@index([difficulty, category])
  @@index([tags])
  @@index([createdById])
  @@index([isPublic])
}

model Submission {
  id            String      @id @default(uuid())
  userId        String
  challengeId   String
  codeSubmitted String      @db.Text
  language      String
  status        SubmissionStatus
  testResults   Json?
  executionTime Int?
  memoryUsed    Int?
  score         Float?
  embedding     Float[]     @db.Vector(1536)
  createdAt     DateTime    @default(now())
  
  user          User        @relation(fields: [userId], references: [id])
  challenge     Challenge   @relation(fields: [challengeId], references: [id])
  feedback      AIFeedback?
  progress      Progress[]

  @@index([userId, challengeId, createdAt])
  @@index([status])
  @@index([language])
}

model AIFeedback {
  id            String      @id @default(uuid())
  submissionId  String      @unique
  strengths     Json
  improvements  Json
  suggestions   Json
  conceptualErrors Json?
  resourceLinks Json?
  score         Float
  tokenCount    Int
  source        String      // 'cache', 'pattern', 'ai', etc.
  modelUsed     String
  processingTime Int?
  createdAt     DateTime    @default(now())
  
  // New fields for feedback quality tracking
  relevanceScore   Float?
  actionabilityScore Float?
  userRating       Float?
  timeToImplement  Int?
  reviewedBy       String?
  reviewScore      Float?
  reviewComments   String?
  
  submission    Submission  @relation(fields: [submissionId], references: [id])
  reviewer      User?       @relation(name: "feedback_reviews", fields: [reviewedBy], references: [id])

  @@index([source])
  @@index([createdAt])
  @@index([relevanceScore])
  @@index([userRating])
}

// New model for instructor review assignments
model FeedbackReview {
  id            String     @id @default(uuid())
  feedbackId    String
  reviewerId    String
  quality       Int        // 1-5 rating
  accuracy      Int        // 1-5 rating  
  actionability Int        // 1-5 rating
  comments      String?
  createdAt     DateTime   @default(now())
  
  feedback      AIFeedback @relation(fields: [feedbackId], references: [id])
  reviewer      User       @relation(fields: [reviewerId], references: [id])
  
  @@unique([feedbackId, reviewerId])
}

model User {
  // ...existing fields...
  
  // New relation for feedback reviews
  feedbackReviews FeedbackReview[]
  reviewedFeedback AIFeedback[] @relation("feedback_reviews")
}

model Progress {
  id                String      @id @default(uuid())
  userId            String
  challengeId       String
  status            ProgressStatus @default(NOT_STARTED)
  bestSubmissionId  String?
  attemptsCount     Int         @default(0)
  firstAttemptedAt  DateTime?
  completedAt       DateTime?
  
  user              User        @relation(fields: [userId], references: [id])
  challenge         Challenge   @relation(fields: [challengeId], references: [id])
  bestSubmission    Submission? @relation(fields: [bestSubmissionId], references: [id])
  
  @@unique([userId, challengeId])
  @@index([status])
  @@index([completedAt])
}

model Course {
  id            String      @id @default(uuid())
  title         String
  description   String      @db.Text
  instructorId  String
  lmsId         String?
  lmsPlatform   String?
  isActive      Boolean     @default(true)
  createdAt     DateTime    @default(now())
  updatedAt     DateTime    @updatedAt
  
  instructor    User        @relation(fields: [instructorId], references: [id])
  challenges    CourseChallenge[]
  enrollments   Enrollment[]

  @@index([instructorId])
  @@index([isActive])
}

model CourseChallenge {
  id            String      @id @default(uuid())
  courseId      String
  challengeId   String
  dueDate       DateTime?
  pointsPossible Float?
  isRequired    Boolean     @default(true)
  orderIndex    Int
  
  course        Course      @relation(fields: [courseId], references: [id])
  challenge     Challenge   @relation(fields: [challengeId], references: [id])
  
  @@unique([courseId, challengeId])
  @@index([dueDate])
}

model Enrollment {
  id            String      @id @default(uuid())
  userId        String
  courseId      String
  role          EnrollmentRole @default(STUDENT)
  lmsUserId     String?
  isActive      Boolean     @default(true)
  createdAt     DateTime    @default(now())
  
  user          User        @relation(fields: [userId], references: [id])
  course        Course      @relation(fields: [courseId], references: [id])
  
  @@unique([userId, courseId])
  @@index([isActive])
}

model LearningPath {
  id            String      @id @default(uuid())
  title         String
  description   String      @db.Text
  difficulty    Difficulty
  estimatedHours Int
  skillsGained  String[]
  isPublic      Boolean     @default(true)
  
  steps         LearningPathStep[]
}

model LearningPathStep {
  id            String      @id @default(uuid())
  pathId        String
  challengeId   String
  order         Int
  isRequired    Boolean     @default(true)
  
  path          LearningPath @relation(fields: [pathId], references: [id])
  challenge     Challenge    @relation(fields: [challengeId], references: [id])
  
  @@unique([pathId, order])
}

model SkillTree {
  id            String      @id @default(uuid())
  name          String
  description   String      @db.Text
  
  nodes         SkillNode[]
}

model SkillNode {
  id            String      @id @default(uuid())
  treeId        String
  name          String
  description   String      @db.Text
  level         Int
  prerequisites String[]
  challengeIds  String[]
  
  tree          SkillTree   @relation(fields: [treeId], references: [id])
  userSkills    UserSkill[]
}

model UserSkill {
  id                String      @id @default(uuid())
  userId            String
  skillNodeId       String
  proficiency       Float
  lastDemonstrated  DateTime
  
  user              User        @relation(fields: [userId], references: [id])
  skillNode         SkillNode   @relation(fields: [skillNodeId], references: [id])
  
  @@unique([userId, skillNodeId])
}

model UsageLog {
  id            String      @id @default(uuid())
  userId        String
  type          String
  challengeId   String?
  tokenCount    Int         @default(0)
  timestamp     DateTime    @default(now())
  
  user          User        @relation(fields: [userId], references: [id])
  
  @@index([userId, type])
  @@index([timestamp])
  @@index([challengeId])
}

model CommonPattern {
  id            String      @id @default(uuid())
  challengeId   String
  language      String
  pattern       String
  description   String
  type          PatternType
  createdAt     DateTime    @default(now())
  
  @@index([challengeId, language])
}

enum UserRole {
  STUDENT
  INSTRUCTOR
  ADMIN
}

enum SubmissionStatus {
  PENDING
  RUNNING
  PASSED
  FAILED
  ERROR
}

enum ProgressStatus {
  NOT_STARTED
  IN_PROGRESS
  COMPLETED
}

enum Difficulty {
  BEGINNER
  INTERMEDIATE
  ADVANCED
  EXPERT
}

enum EnrollmentRole {
  STUDENT
  TEACHING_ASSISTANT
  INSTRUCTOR
}

enum PatternType {
  STRENGTH
  IMPROVEMENT
  SUGGESTION
}
```

### 5.3 Indexing Strategy

The database schema includes strategic indexes to optimize query performance:

1. **User Lookups**: 
   - Indexed by email for authentication
   - Indexed by role for role-based queries and filtering

2. **Challenge Filtering**:
   - Composite index on difficulty and category for efficient filtering
   - Index on tags for tag-based searches
   - Index on createdById for instructor's challenges
   - Index on isPublic for public/private filtering

3. **Submission History**:
   - Composite index on userId, challengeId, and createdAt for timeline views
   - Index on status for filtering by submission status
   - Index on language for filtering by programming language

4. **Progress Tracking**:
   - Unique constraint on userId and challengeId for fast lookups
   - Index on status for completion rate calculations
   - Index on completedAt for timeline analysis

5. **Feedback Analysis**:
   - Index on source to filter by feedback generation method
   - Index on createdAt for timeline analysis

6. **Vector Similarity**:
   - Vector type for embedding column enables efficient similarity searches
   - Critical for finding similar code submissions

### 5.4 Database Migrations

Prisma handles database migrations with version control:

```bash
# Generate migration from schema changes
npx prisma migrate dev --name add_learning_paths

# Apply migrations in production
npx prisma migrate deploy
```

Example migration for adding vector support:

```sql
-- Migration name: add_vector_embedding
-- Description: Add vector support for code similarity search

-- Enable vector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Add vector field to Submission table
ALTER TABLE "Submission" ADD COLUMN IF NOT EXISTS "embedding" vector(1536);

-- Create index for vector similarity searches
CREATE INDEX IF NOT EXISTS embedding_idx ON "Submission" USING ivfflat ("embedding" vector_l2_ops) WITH (lists = 100);
```

### 5.5 Query Optimization Techniques

```typescript
// Example of an optimized query using Prisma raw queries
// This avoids the N+1 problem by using a single efficient query
async function getSubmissionsWithFeedback(challengeId: string, limit: number = 10) {
  // Using a single query with joins instead of multiple separate queries
  return await prisma.$queryRaw`
    SELECT s.id, s.status, s.score, s."createdAt", 
           u.id as "userId", u.name as "userName",
           f.id as "feedbackId", f.score as "feedbackScore"
    FROM "Submission" s
    JOIN "User" u ON s."userId" = u.id
    LEFT JOIN "AIFeedback" f ON s.id = f."submissionId"
    WHERE s."challengeId" = ${challengeId}
    ORDER BY s."createdAt" DESC
    LIMIT ${limit}
  `;
}

// Example of using Prisma's include for efficient eager loading
async function getChallengeWithDetails(challengeId: string) {
  return await prisma.challenge.findUnique({
    where: { id: challengeId },
    include: {
      createdBy: {
        select: { id: true, name: true } // Select only needed fields
      },
      _count: {
        select: { submissions: true } // Count submissions efficiently
      }
    }
  });
}

// Example of efficient pagination with cursor-based approach
async function getUserSubmissionsPaginated(userId: string, cursor?: string, limit: number = 20) {
  return await prisma.submission.findMany({
    where: { userId },
    take: limit,
    cursor: cursor ? { id: cursor } : undefined,
    orderBy: { createdAt: 'desc' },
    include: {
      challenge: {
        select: { id: true, title: true } // Select only needed fields
      }
    }
  });
}
```

## 6. API Design

### 6.1 RESTful API Endpoints

The platform exposes a comprehensive RESTful API with consistent patterns:

#### 6.1.1 Authentication API

```
POST /api/auth/register
- Register a new user
- Request: { name, email, password }
- Response: { token, user }

POST /api/auth/login
- Authenticate a user
- Request: { email, password }
- Response: { token, user }

POST /api/auth/github
- Authenticate with GitHub
- Request: { code }
- Response: { token, user }

GET /api/auth/me
- Get current user data
- Headers: Authorization: Bearer [token]
- Response: { user }

POST /api/auth/logout
- Invalidate the current session
- Headers: Authorization: Bearer [token]
- Response: { success: true }
```

#### 6.1.2 User API

```
GET /api/users/me/profile
- Get user profile data
- Headers: Authorization: Bearer [token]
- Response: { profile }

PUT /api/users/me/profile
- Update user profile
- Headers: Authorization: Bearer [token]
- Request: { name, profileImage, settings }
- Response: { profile }

GET /api/users/me/progress
- Get user progress stats
- Headers: Authorization: Bearer [token]
- Response: { progress, stats }

GET /api/users/me/submissions
- Get user submission history
- Headers: Authorization: Bearer [token]
- Query: ?page=1&limit=20&challengeId=...
- Response: { submissions, pagination }
```

#### 6.1.3 Challenge API

```
GET /api/challenges
- List available challenges
- Query: ?difficulty=BEGINNER&category=algorithms&search=sort&page=1&limit=20
- Response: { challenges, pagination }

GET /api/challenges/:id
- Get challenge details
- Response: { challenge }

POST /api/challenges
- Create a new challenge (instructor only)
- Headers: Authorization: Bearer [token]
- Request: { title, description, ... }
- Response: { challenge }

PUT /api/challenges/:id
- Update a challenge (creator or admin only)
- Headers: Authorization: Bearer [token]
- Request: { title, description, ... }
- Response: { challenge }

GET /api/challenges/categories
- Get all challenge categories
- Response: { categories }
```

#### 6.1.4 Submission API

```
POST /api/submissions
- Submit code for a challenge
- Headers: Authorization: Bearer [token]
- Request: { challengeId, language, code }
- Response: { submission, testResults }

GET /api/submissions/:id
- Get submission details
- Headers: Authorization: Bearer [token]
- Response: { submission, testResults }

GET /api/submissions/:id/feedback
- Get AI feedback for a submission
- Headers: Authorization: Bearer [token]
- Response: { feedback }

POST /api/submissions/:id/feedback/regenerate
- Regenerate AI feedback (premium feature)
- Headers: Authorization: Bearer [token]
- Response: { jobId }

GET /api/submissions/feedback/job/:jobId
- Check status of feedback generation job
- Headers: Authorization: Bearer [token]
- Response: { status, feedback? }
```

#### 6.1.5 Analytics API

```
GET /api/analytics/me
- Get personal analytics
- Headers: Authorization: Bearer [token]
- Response: { progressSummary, recentActivity, ... }

GET /api/analytics/instructor/challenges
- Get instructor challenge analytics
- Headers: Authorization: Bearer [token]
- Response: { challengeStats, submissionStats, ... }

GET /api/analytics/challenge/:id
- Get detailed challenge analytics
- Headers: Authorization: Bearer [token]
- Response: { submissionStats, userStats, ... }
```

#### 6.1.6 Course API (Phase 2)

```
GET /api/courses
- List available courses
- Headers: Authorization: Bearer [token]
- Response: { courses, pagination }

GET /api/courses/:id
- Get course details
- Headers: Authorization: Bearer [token]
- Response: { course, challenges, enrollment }

POST /api/courses
- Create a new course (instructor only)
- Headers: Authorization: Bearer [token]
- Request: { title, description, ... }
- Response: { course }

POST /api/courses/:id/enroll
- Enroll in a course
- Headers: Authorization: Bearer [token]
- Response: { enrollment }

GET /api/courses/:id/students
- Get enrolled students (instructor only)
- Headers: Authorization: Bearer [token]
- Response: { students, pagination }
```

### 6.2 API Documentation with OpenAPI

All API endpoints are documented with OpenAPI 3.0 specifications:

```yaml
# openapi.yaml
openapi: 3.0.0
info:
  title: KodeLab API
  version: 1.0.0
  description: API for the KodeLab coding platform
servers:
  - url: https://api.kodelab.io/api
    description: Production server
  - url: https://staging.kodelab.io/api
    description: Staging server
  - url: http://localhost:4000/api
    description: Local development server

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
  
  schemas:
    Error:
      type: object
      properties:
        error:
          type: object
          properties:
            message:
              type: string
            code:
              type: string
      required:
        - error
    
    User:
      type: object
      properties:
        id:
          type: string
          format: uuid
        name:
          type: string
        email:
          type: string
          format: email
        role:
          type: string
          enum: [STUDENT, INSTRUCTOR, ADMIN]
        profileImage:
          type: string
          nullable: true
      required:
        - id
        - name
        - email
        - role
    
    Challenge:
      type: object
      properties:
        id:
          type: string
          format: uuid
        title:
          type: string
        description:
          type: string
        difficulty:
          type: string
          enum: [BEGINNER, INTERMEDIATE, ADVANCED, EXPERT]
        category:
          type: string
        tags:
          type: array
          items:
            type: string
        estimatedTime:
          type: integer
          description: Estimated time to complete in minutes
        createdAt:
          type: string
          format: date-time
      required:
        - id
        - title
        - description
        - difficulty
        - category

paths:
  /auth/register:
    post:
      summary: Register a new user
      tags:
        - Authentication
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                name:
                  type: string
                email:
                  type: string
                  format: email
                password:
                  type: string
                  format: password
              required:
                - name
                - email
                - password
      responses:
        '201':
          description: User successfully registered
          content:
            application/json:
              schema:
                type: object
                properties:
                  token:
                    type: string
                  user:
                    $ref: '#/components/schemas/User'
        '400':
          description: Invalid input
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
        '409':
          description: Email already in use
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
  
  /challenges:
    get:
      summary: List available challenges
      tags:
        - Challenges
      parameters:
        - name: difficulty
          in: query
          schema:
            type: string
            enum: [BEGINNER, INTERMEDIATE, ADVANCED, EXPERT]
        - name: category
          in: query
          schema:
            type: string
        - name: search
          in: query
          schema:
            type: string
        - name: page
          in: query
          schema:
            type: integer
            default: 1
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
      responses:
        '200':
          description: List of challenges
          content:
            application/json:
              schema:
                type: object
                properties:
                  challenges:
                    type: array
                    items:
                      $ref: '#/components/schemas/Challenge'
                  pagination:
                    type: object
                    properties:
                      page:
                        type: integer
                      limit:
                        type: integer
                      total:
                        type: integer
                      pages:
                        type: integer
    
    post:
      summary: Create a new challenge
      tags:
        - Challenges
      security:
        - bearerAuth: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                title:
                  type: string
                description:
                  type: string
                difficulty:
                  type: string
                  enum: [BEGINNER, INTERMEDIATE, ADVANCED, EXPERT]
                category:
                  type: string
                instructions:
                  type: string
                starterCode:
                  type: string
                solutionCode:
                  type: string
                testCases:
                  type: array
                  items:
                    type: object
                    properties:
                      description:
                        type: string
                      functionName:
                        type: string
                      input:
                        type: string
                      expectedOutput:
                        type: string
                      isPublic:
                        type: boolean
                        default: true
                hints:
                  type: array
                  items:
                    type: string
                tags:
                  type: array
                  items:
                    type: string
                estimatedTime:
                  type: integer
                isPublic:
                  type: boolean
                  default: true
              required:
                - title
                - description
                - difficulty
                - category
                - instructions
                - starterCode
                - solutionCode
                - testCases
      responses:
        '201':
          description: Challenge created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Challenge'
        '400':
          description: Invalid input
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
        '401':
          description: Unauthorized
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
        '403':
          description: Forbidden - not an instructor
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
  
  /submissions:
    post:
      summary: Submit code for a challenge
      tags:
        - Submissions
      security:
        - bearerAuth: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                challengeId:
                  type: string
                  format: uuid
                code:
                  type: string
                language:
                  type: string
              required:
                - challengeId
                - code
                - language
      responses:
        '201':
          description: Submission created
          content:
            application/json:
              schema:
                type: object
                properties:
                  id:
                    type: string
                    format: uuid
                  status:
                    type: string
                    enum: [PENDING, RUNNING, PASSED, FAILED, ERROR]
                  testResults:
                    type: array
                    items:
                      type: object
                      properties:
                        id:
                          type: integer
                        description:
                          type: string
                        passed:
                          type: boolean
                        actualOutput:
                          type: string
                        error:
                          type: string
                          nullable: true
                  executionTime:
                    type: integer
                  score:
                    type: number
                  feedbackStatus:
                    type: string
                    enum: [pending, ready, error]
                    nullable: true
        '400':
          description: Invalid input
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
        '401':
          description: Unauthorized
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
```

### 6.3 API Security

#### 6.3.1 Authentication Middleware

```typescript
// middleware/auth.middleware.ts
import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { prisma } from '../lib/prisma';
import { redis } from '../lib/redis';
import { UnauthorizedError, ForbiddenError } from '../lib/errors';
import { logger } from '../lib/logger';

export interface AuthRequest extends Request {
  user?: {
    id: string;
    role: string;
  };
}

// Authenticate middleware - validates JWT token and attaches user to request
export const authenticate = async (
  req: AuthRequest, 
  res: Response, 
  next: NextFunction
) => {
  try {
    // Get token from Authorization header
    const authHeader = req.headers.authorization;
    
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new UnauthorizedError('No token provided');
    }
    
    const token = authHeader.split(' ')[1];
    
    // Verify token
    const decoded = jwt.verify(token, process.env.JWT_SECRET) as any;
    
    // Check if token has required fields
    if (!decoded.userId) {
      throw new UnauthorizedError('Invalid token');
    }
    
    // Check if token has been revoked
    const tokenHash = crypto.createHash('sha256').update(token).digest('hex');
    const isRevoked = await redis.get(`auth:revoked:${decoded.userId}:${tokenHash}`);
    
    if (isRevoked) {
      throw new UnauthorizedError('Token has been revoked');
    }
    
    // Verify user exists
    const user = await prisma.user.findUnique({
      where: { id: decoded.userId },
      select: { id: true, role: true }
    });
    
    if (!user) {
      throw new UnauthorizedError('User not found');
    }
    
    // Attach user to request
    req.user = {
      id: user.id,
      role: user.role
    };
    
    // Track last activity
    await redis.set(`user:lastActivity:${user.id}`, Date.now().toString(), 'EX', 86400 * 7);
    
    next();
  } catch (error) {
    logger.error('Authentication error', { 
      path: req.path,
      error: error.message 
    });
    
    if (error.name === 'JsonWebTokenError' || error.name === 'TokenExpiredError') {
      next(new UnauthorizedError('Invalid or expired token'));
    } else {
      next(error);
    }
  }
};

// Authorization middleware - checks if user has required role
export const authorize = (roles: string[]) => {
  return (req: AuthRequest, res: Response, next: NextFunction) => {
    if (!req.user) {
      throw new UnauthorizedError('Authentication required');
    }
    
    if (!roles.includes(req.user.role)) {
      logger.warn('Unauthorized access attempt', {
        userId: req.user.id,
        role: req.user.role,
        requiredRoles: roles,
        path: req.path
      });
      
      throw new ForbiddenError('Insufficient permissions');
    }
    
    next();
  };
};
```

#### 6.3.2 Request Validation Middleware

```typescript
// middleware/validation.middleware.ts
import { Request, Response, NextFunction } from 'express';
import { z } from 'zod';
import { BadRequestError } from '../lib/errors';

// Middleware to validate request body against a Zod schema
export const validateBody = (schema: z.ZodType<any, any>) => {
  return (req: Request, res: Response, next: NextFunction) => {
    try {
      // Parse and validate request body
      const validatedData = schema.parse(req.body);
      
      // Replace request body with validated data
      req.body = validatedData;
      
      next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        // Format Zod validation errors
        const formattedErrors = error.errors.map(err => ({
          path: err.path.join('.'),
          message: err.message
        }));
        
        next(new BadRequestError('Validation error', formattedErrors));
      } else {
        next(error);
      }
    }
  };
};

// Middleware to validate request query parameters
export const validateQuery = (schema: z.ZodType<any, any>) => {
  return (req: Request, res: Response, next: NextFunction) => {
    try {
      // Parse and validate query parameters
      const validatedData = schema.parse(req.query);
      
      // Replace query with validated data
      req.query = validatedData;
      
      next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        const formattedErrors = error.errors.map(err => ({
          path: err.path.join('.'),
          message: err.message
        }));
        
        next(new BadRequestError('Invalid query parameters', formattedErrors));
      } else {
        next(error);
      }
    }
  };
};

// Middleware to validate request params
export const validateParams = (schema: z.ZodType<any, any>) => {
  return (req: Request, res: Response, next: NextFunction) => {
    try {
      // Parse and validate route parameters
      const validatedData = schema.parse(req.params);
      
      // Replace params with validated data
      req.params = validatedData;
      
      next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        const formattedErrors = error.errors.map(err => ({
          path: err.path.join('.'),
          message: err.message
        }));
        
        next(new BadRequestError('Invalid route parameters', formattedErrors));
      } else {
        next(error);
      }
    }
  };
};
```

#### 6.3.3 Rate Limiting Middleware

```typescript
// middleware/rate-limit.middleware.ts
import { Request, Response, NextFunction } from 'express';
import { redis } from '../lib/redis';
import { TooManyRequestsError } from '../lib/errors';
import { AuthRequest } from './auth.middleware';

interface RateLimitOptions {
  windowMs: number;  // Time window in milliseconds
  max: number;       // Maximum requests in the time window
  keyGenerator?: (req: Request) => string; // Function to generate a key
  handler?: (req: Request, res: Response) => void; // Custom handler
}

// Rate limiting middleware
export const rateLimit = (options: RateLimitOptions) => {
  const {
    windowMs = 60 * 1000, // 1 minute default
    max = 100,            // 100 requests per minute default
    keyGenerator = getDefaultKey,
    handler = defaultHandler
  } = options;
  
  return async (req: Request, res: Response, next: NextFunction) => {
    const key = keyGenerator(req);
    
    try {
      // Get current count and increment
      const current = await redis.incr(key);
      
      // Set expiry if this is the first request in the window
      if (current === 1) {
        await redis.expire(key, Math.floor(windowMs / 1000));
      }
      
      // Set rate limit headers
      res.setHeader('X-RateLimit-Limit', max.toString());
      res.setHeader('X-RateLimit-Remaining', Math.max(0, max - current).toString());
      
      // Check if limit exceeded
      if (current > max) {
        return handler(req, res);
      }
      
      next();
    } catch (error) {
      // If Redis fails, allow the request to proceed
      next();
    }
  };
};

// Default key generator
function getDefaultKey(req: Request): string {
  // Use user ID if authenticated, otherwise IP
  const userId = (req as AuthRequest).user?.id;
  const ip = req.ip || req.socket.remoteAddress || 'unknown';
  const endpoint = req.originalUrl || req.url;
  
  return userId 
    ? `ratelimit:user:${userId}:${endpoint}`
    : `ratelimit:ip:${ip}:${endpoint}`;
}

// Default rate limit exceeded handler
function defaultHandler(req: Request, res: Response) {
  const error = new TooManyRequestsError('Too many requests');
  res.status(429).json({ error: { message: error.message, code: error.code } });
}

// Specific limiters for different endpoints
export const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 10, // 10 requests per 15 minutes
  keyGenerator: (req) => `ratelimit:auth:${req.ip}`,
});

export const submissionLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: 5, // 5 submissions per minute
  keyGenerator: (req: Request) => {
    const userId = (req as AuthRequest).user?.id;
    return `ratelimit:submissions:${userId}`;
  }
});

export const apiLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: 100, // 100 requests per minute
});
```

### 6.4 API Response Standards

```typescript
// lib/api-response.ts
import { Response } from 'express';

/**
 * Standard API response utility for consistent response formatting
 */
export class ApiResponse {
  /**
   * Send a success response with status 200
   * @param res Express response object
   * @param data Response data
   * @param message Optional success message
   */
  static success(res: Response, data: any, message?: string) {
    return res.status(200).json({
      success: true,
      message: message || 'Operation successful',
      data
    });
  }
  
  /**
   * Send a created response with status 201
   * @param res Express response object
   * @param data Created resource data
   * @param message Optional success message
   */
  static created(res: Response, data: any, message?: string) {
    return res.status(201).json({
      success: true,
      message: message || 'Resource created',
      data
    });
  }
  
  /**
   * Send a no content response with status 204
   * @param res Express response object
   */
  static noContent(res: Response) {
    return res.status(204).end();
  }
  
  /**
   * Send an error response
   * @param res Express response object
   * @param statusCode HTTP status code
   * @param message Error message
   * @param code Optional error code
   * @param details Optional error details
   */
  static error(
    res: Response, 
    statusCode: number,
    message: string,
    code?: string,
    details?: any
  ) {
    const response: any = {
      success: false,
      error: {
        message,
        code: code || 'ERROR'
      }
    };
    
    if (details) {
      response.error.details = details;
    }
    
    return res.status(statusCode).json(response);
  }
  
  /**
   * Send a paginated response
   * @param res Express response object
   * @param data Array of items
   * @param pagination Pagination metadata
   */
  static paginated(
    res: Response,
    data: any[],
    pagination: {
      page: number;
      limit: number;
      total: number;
      pages: number;
    }
  ) {
    return res.status(200).json({
      success: true,
      data,
      pagination
    });
  }
}
```

## 7. Frontend Architecture

### 7.1 Component Structure

The frontend is organized into a clear component hierarchy:

```
src/
├── app/                      # Next.js App Router
│   ├── dashboard/
│   │   └── page.tsx          # Student dashboard
│   ├── challenge/
│   │   └── [id]/
│   │       └── page.tsx      # Challenge page
│   ├── profile/
│   │   └── page.tsx          # User profile
│   └── layout.tsx            # Root layout
├── components/
│   ├── ui/                   # Base UI components
│   │   ├── button.tsx
│   │   ├── dropdown.tsx
│   │   └── ...
│   ├── dashboard/            # Dashboard components
│   │   ├── progress-chart.tsx
│   │   ├── challenge-list.tsx
│   │   └── ...
│   ├── challenge/            # Challenge components
│   │   ├── editor.tsx
│   │   ├── test-results.tsx
│   │   └── ...
│   └── feedback/             # Feedback components
│       ├── feedback-display.tsx
│       ├── strength-card.tsx
│       └── ...
├── lib/
│   ├── api/                  # API integration
│   │   ├── auth.ts
│   │   ├── challenges.ts
│   │   └── ...
│   ├── state/                # State management
│   │   ├── auth-store.ts
│   │   ├── editor-store.ts
│   │   └── ...
│   └── utils/                # Utility functions
│       ├── formatting.ts
│       ├── validation.ts
│       └── ...
└── styles/
    └── globals.css           # Global styles
```

### 7.2 Page Implementation Example

```tsx
// app/challenge/[id]/page.tsx
import { Suspense } from 'react';
import { notFound } from 'next/navigation';
import { getChallengeById } from '@/lib/api-server/challenges';
import { ChallengePage } from '@/components/challenge/challenge-page';
import { ChallengePageSkeleton } from '@/components/challenge/challenge-page-skeleton';
import { getUserProgress } from '@/lib/api-server/progress';
import { getCurrentUser } from '@/lib/auth-server';

export const dynamic = 'force-dynamic';

export async function generateMetadata({ params }: { params: { id: string } }) {
  try {
    const challenge = await getChallengeById(params.id);
    
    return {
      title: `${challenge.title} | KodeLab Challenge`,
      description: challenge.description,
      openGraph: {
        title: `${challenge.title} | KodeLab Challenge`,
        description: challenge.description,
        type: 'website',
        url: `https://kodelab.io/challenge/${params.id}`,
      }
    };
  } catch (error) {
    return {
      title: 'Challenge | KodeLab',
      description: 'Solve coding challenges and improve your programming skills'
    };
  }
}

export default async function ChallengePage({ params }: { params: { id: string } }) {
  const challengeId = params.id;
  
  // Get current user
  const user = await getCurrentUser();
  
  // Get challenge data from API
  try {
    const challenge = await getChallengeById(challengeId, user?.id);
    
    // Get user progress if logged in
    let progress = null;
    if (user) {
      progress = await getUserProgress(user.id, challengeId);
    }
    
    return (
      <Suspense fallback={<ChallengePageSkeleton />}>
        <ChallengePage 
          challenge={challenge} 
          progress={progress} 
          userId={user?.id}
        />
      </Suspense>
    );
  } catch (error) {
    // Handle 404 for missing challenge
    notFound();
  }
}
```

### 7.3 Client Component Example

```tsx
// components/challenge/challenge-page.tsx
'use client';

import { useState } from 'react';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { useRouter } from 'next/navigation';
import { submitChallenge } from '@/lib/api/challenges';
import { useEditorStore } from '@/lib/state/editor-store';
import { Challenge, Progress } from '@/types';
import { ChallengeHeader } from './challenge-header';
import { ChallengeDescription } from './challenge-description';
import { CodeEditor } from './editor';
import { TestResults } from './test-results';
import { FeedbackPanel } from '../feedback/feedback-panel';
import { useToast } from '@/components/ui/use-toast';
import {
  ResizableHandle,
  ResizablePanel,
  ResizablePanelGroup,
} from '@/components/ui/resizable';

interface ChallengePageProps {
  challenge: Challenge;
  progress?: Progress | null;
  userId?: string;
}

/**
 * Challenge page component that handles code submission and displays results
 */
export function ChallengePage({ challenge, progress, userId }: ChallengePageProps) {
  const { code, language, setCode, setLanguage } = useEditorStore();
  const [submissionId, setSubmissionId] = useState<string | null>(null);
  const queryClient = useQueryClient();
  const router = useRouter();
  const { toast } = useToast();
  
  // Initialize editor with challenge starter code
  useState(() => {
    if (challenge.starterCode && (!code || code === '')) {
      setCode(challenge.starterCode);
    }
  });
  
  // Submit challenge mutation
  const submitMutation = useMutation({
    mutationFn: () => submitChallenge(challenge.id, code, language),
    onSuccess: (data) => {
      setSubmissionId(data.id);
      
      // Show success/failure toast
      toast({
        title: data.status === 'PASSED' ? 'Success!' : 'Tests Failed',
        description: data.status === 'PASSED' 
          ? 'Your solution passed all tests.' 
          : 'Your solution did not pass all tests.',
        variant: data.status === 'PASSED' ? 'default' : 'destructive'
      });
      
      // Invalidate relevant queries
      queryClient.invalidateQueries({
        queryKey: ['submissions', 'user']
      });
      
      // Update progress data
      queryClient.invalidateQueries({
        queryKey: ['progress', userId, challenge.id]
      });
    },
    onError: (error) => {
      console.error('Submission error:', error);
      toast({
        title: 'Submission Failed',
        description: 'An error occurred while submitting your solution.',
        variant: 'destructive'
      });
    }
  });
  
  const handleSubmit = () => {
    if (!userId) {
      // Prompt login for non-authenticated users
      router.push('/login?returnUrl=' + encodeURIComponent(`/challenge/${challenge.id}`));
      return;
    }
    
    submitMutation.mutate();
  };
  
  return (
    <div className="container mx-auto py-6">
      <ChallengeHeader 
        title={challenge.title}
        difficulty={challenge.difficulty}
        category={challenge.category}
        tags={challenge.tags}
        progress={progress}
      />
      
      <ResizablePanelGroup
        direction="horizontal"
        className="min-h-[600px] rounded-lg border"
      >
        <ResizablePanel defaultSize={40} minSize={30}>
          <div className="p-6 h-full overflow-auto">
            <ChallengeDescription
              description={challenge.description}
              instructions={challenge.instructions}
              testCases={challenge.testCases}
            />
          </div>
        </ResizablePanel>
        
        <ResizableHandle withHandle />
        
        <ResizablePanel defaultSize={60}>
          <div className="flex flex-col h-full">
            <div className="flex-grow">
              <CodeEditor
                initialCode={challenge.starterCode}
                language={language}
                onChange={setCode}
                onSubmit={handleSubmit}
                isSubmitting={submitMutation.isPending}
              />
            </div>
            
            {submitMutation.data && (
              <div className="p-4 border-t">
                <TestResults results={submitMutation.data.testResults} />
              </div>
            )}
            
            {submissionId && submitMutation.data?.status === 'PASSED' && (
              <div className="p-4 border-t">
                <FeedbackPanel submissionId={submissionId} />
              </div>
            )}
          </div>
        </ResizablePanel>
      </ResizablePanelGroup>
    </div>
  );
}
```

### 7.4 API Integration

```typescript
// lib/api/challenges.ts
import axios from 'axios';
import { Challenge, ChallengeFilters, Pagination, Submission } from '@/types';

const API_URL = process.env.NEXT_PUBLIC_API_URL || '';

/**
 * Get paginated list of challenges
 * @param filters Challenge filters and pagination
 * @returns Promise with challenges and pagination data
 */
export async function getChallenges(filters: ChallengeFilters = {}) {
  const { 
    difficulty, 
    category, 
    tags, 
    search, 
    page = 1, 
    limit = 20 
  } = filters;
  
  // Build query string
  const params = new URLSearchParams();
  if (difficulty) params.append('difficulty', difficulty);
  if (category) params.append('category', category);
  if (search) params.append('search', search);
  if (tags && tags.length) {
    tags.forEach(tag => params.append('tags', tag));
  }
  params.append('page', page.toString());
  params.append('limit', limit.toString());
  
  try {
    const response = await axios.get(`${API_URL}/api/challenges?${params.toString()}`, {
      withCredentials: true
    });
    
    return response.data;
  } catch (error) {
    console.error('Error fetching challenges:', error);
    throw error;
  }
}

/**
 * Get a specific challenge by ID
 * @param id Challenge ID
 * @returns Promise with challenge data
 */
export async function getChallenge(id: string) {
  try {
    const response = await axios.get(`${API_URL}/api/challenges/${id}`, {
      withCredentials: true
    });
    
    return response.data as Challenge;
  } catch (error) {
    console.error('Error fetching challenge:', error);
    throw error;
  }
}

/**
 * Submit a solution for a challenge
 * @param challengeId Challenge ID
 * @param code User's code solution
 * @param language Programming language
 * @returns Promise with submission results
 */
export async function submitChallenge(
  challengeId: string, 
  code: string, 
  language: string
) {
  try {
    const response = await axios.post(
      `${API_URL}/api/submissions`,
      {
        challengeId,
        code,
        language
      },
      {
        withCredentials: true,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
    
    return response.data as Submission;
  } catch (error) {
    console.error('Error submitting challenge:', error);
    throw error;
  }
}

/**
 * Create a new challenge (instructor only)
 * @param challengeData Challenge data
 * @returns Promise with created challenge
 */
export async function createChallenge(challengeData: any) {
  try {
    const response = await axios.post(
      `${API_URL}/api/challenges`,
      challengeData,
      {
        withCredentials: true,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );
    
    return response.data as Challenge;
  } catch (error) {
    console.error('Error creating challenge:', error);
    throw error;
  }
}
```

## 8. AI Feedback System

### 8.1 AI Feedback Processing Flow

```mermaid
flowchart TD
    A[Code Submission] --> B[Submission Service]
    B --> C{Tests Passed?}
    C -->|No| D[Return Test Results]
    C -->|Yes| E[AI Feedback Service]
    
    E --> F{Check Cache}
    F -->|Cache Hit| G[Return Cached Feedback]
    F -->|Cache Miss| H[Check Similar Submissions]
    
    H -->|Similar Found| I[Adapt Similar Feedback]
    H -->|No Similar Submissions| J[Pattern Analysis]
    
    J -->|Patterns Detected| K[Generate Pattern Feedback]
    J -->|No Patterns| L[Check User Quota]
    
    L -->|Quota Exceeded| M[Generate Basic Feedback]
    L -->|Quota Available| N[Optimize AI Prompt]
    
    N --> O[Call External AI API]
    O --> P[Process AI Response]
    P --> Q[Store Feedback]
    Q --> R[Cache Results]
    
    I --> R
    K --> R
    M --> R
    G --> S[Return Feedback to User]
    R --> S
    
    S --> T[Collect Feedback Quality Metrics]
    T --> U[Update Feedback Patterns]
```

### 8.2 AI Feedback Quality Metrics

The platform implements a comprehensive system to measure and continuously improve feedback quality:

#### 8.2.1 User-Driven Metrics

- **Relevance Rating**: Users rate feedback relevance on a 1-5 scale, measuring how well the feedback addresses their specific code
- **Actionability Score**: Automated analysis of the ratio between suggestions and implemented changes
- **Time-to-Implement**: Tracking how long users take to implement suggestions (for completed challenges)
- **User Satisfaction**: Overall rating of feedback usefulness
- **Educational Value**: Rating of how much the feedback enhanced understanding of concepts
- **Clarity Assessment**: Rating of communication clarity and understandability

#### 8.2.2 Instructor Review Loop

- **Scheduled Reviews**: Automated selection of feedback samples for instructor review
- **Quality Assessment**: Instructors rate accuracy, educational value, and alignment with learning objectives
- **Pattern Identification**: System identifies recurring patterns in highly-rated feedback
- **Continuous Improvement**: Feedback metrics inform prompt engineering and model selection
- **Feedback Validation**: Instructors periodically validate AI feedback against best practices
- **Educational Alignment**: Assessment of feedback alignment with curriculum objectives

#### 8.2.3 Metrics Dashboard

```typescript
// Example metrics tracking implementation
interface FeedbackMetrics {
  relevanceScore: number;   // 0-100 based on user ratings
  actionabilityScore: number; // 0-100 based on specific suggestions
  userRating?: number;      // 1-5 star user rating
  timeToImplement?: number; // Minutes taken to implement suggestions
  instructorReview?: {
    accuracy: number;       // 1-5 instructor rating
    educationalValue: number; // 1-5 instructor rating
    suggestionsApplied: number; // % of suggestions user implemented
  }
}
```

The metrics dashboard provides:
- Trending quality metrics over time
- Comparison across different AI models
- Performance breakdown by challenge type and difficulty
- Cost-effectiveness analysis (quality per token)
- Educational impact measurements
- Pattern effectiveness tracking

#### 8.2.4 Enhanced Pattern Library

The system maintains an extensive library of code patterns categorized by:

- Programming language
- Challenge type
- Conceptual areas (algorithms, data structures, etc.)
- Common student mistakes and misconceptions
- Best practice implementations
- Performance optimization techniques

Pattern detection significantly reduces AI API costs while maintaining feedback quality. The pattern library is continuously expanded through:

- Automated extraction from high-quality AI feedback
- Instructor contributions
- Analysis of common patterns in student submissions
- Integration with industry coding standards

### 8.3 AI Feedback Service Implementation

The AI Feedback Service uses a multi-tiered approach to generate personalized code feedback while optimizing costs:

```typescript
// services/ai-feedback.service.ts
import { createHash } from 'crypto';
import { Queue } from 'bull';
import { prisma } from '../lib/prisma';
import { redis } from '../lib/redis';
import { aiProvider } from '../lib/ai-provider';
import { logger } from '../lib/logger';

// Setup feedback queue
const feedbackQueue = new Queue('ai-feedback', {
  redis: {
    host: process.env.REDIS_HOST,
    port: parseInt(process.env.REDIS_PORT || '6379')
  },
  defaultJobOptions: {
    attempts: 3,
    backoff: { type: 'exponential', delay: 5000 },
    removeOnComplete: true
  }
});

export class AIFeedbackService {
  /**
   * Generate feedback for code submission
   * @param request Feedback request parameters
   * @returns Job ID or feedback response
   */
  async generateFeedback(request: FeedbackRequest): Promise<string | FeedbackResponse> {
    const { submissionId, code, language, challengeId, userId, urgent = false, subscriptionTier = 'free' } = request;
    
    try {
      // Quality metrics tracking
      const metricsContext = await this.initializeMetricsContext(submissionId);
      
      // Pattern matching before AI processing
      const patternMatch = await this.patternLibrary.findMatches(code, language);
      if (patternMatch && !urgent) {
        await this.recordMetrics(metricsContext, 'pattern_match_success');
        return this.generatePatternBasedFeedback(patternMatch);
      }

      // For non-urgent requests, queue processing and return job ID
      if (!urgent) {
        const job = await feedbackQueue.add(
          { submissionId, code, language, challengeId, userId, urgent: false },
          { 
            attempts: 3,
            backoff: { type: 'exponential', delay: 5000 }
          }
        );
        
        await redis.set(
          `feedback:pending:${submissionId}`, 
          '1', 
          'EX', 
          300 // 5 minutes
        );
        
        return job.id.toString();
      }

      // Urgent processing with fallback mechanisms
      return await this.processUrgentFeedback(request, metricsContext);
    } catch (error) {
      await this.handleFeedbackError(error, submissionId);
      throw error;
    }
    
    // Analyze for patterns (third fastest path)
    const patternResult = await this.analyzePatterns(code, language, challengeId);
    if (patternResult.confidence > 0.7) {
      await this.trackUsage(userId, 'pattern_match');
      await this.saveFeedback(submissionId, patternResult.feedback);
      await this.cacheResult(codeFingerprint, patternResult.feedback);
      return { ...patternResult.feedback, source: 'pattern' };
    }
    
    // Check user's AI usage quota
    const hasQuota = await this.checkUserQuota(userId);
    if (!hasQuota) {
      const basicFeedback = this.generateBasicFeedback(code, language);
      await this.trackUsage(userId, 'quota_exceeded');
      await this.saveFeedback(submissionId, basicFeedback);
      return { ...basicFeedback, source: 'basic' };
    }
    
    try {
      // Get challenge context for AI prompt
      const challenge = await prisma.challenge.findUnique({
        where: { id: challengeId },
        select: {
          title: true,
          description: true,
          difficulty: true,
          category: true,
          learningOutcomes: true
        }
      });
      
      if (!challenge) {
        throw new Error('Challenge not found');
      }
      
      // Create optimized prompt
      const prompt = this.createPrompt(code, language, challenge);
      
      // Call AI API
      const startTime = Date.now();
      const aiResponse = await aiProvider.generateFeedback(prompt, {
        model: 'gpt-4',
        temperature: 0.3,
        maxTokens: 800
      });
      const processingTime = Date.now() - startTime;
      
      // Parse AI response
      const feedback = this.parseAIResponse(aiResponse, processingTime);
      
      // Track token usage for quotas and billing
      const tokenCount = aiResponse.usage?.totalTokens || 500;
      await this.trackUsage(userId, 'ai_feedback', tokenCount);
      
      // Save feedback to database
      await this.saveFeedback(submissionId, feedback);
      
      // Store embedding for future similarity matching
      await this.storeEmbedding(submissionId, code);
      
      // Cache result
      await this.cacheResult(codeFingerprint, feedback);
      
      return { ...feedback, source: 'ai' };
    } catch (error) {
      logger.error('AI feedback error', { error, submissionId });
      
      // Generate fallback feedback on error
      const basicFeedback = this.generateBasicFeedback(code, language);
      await this.trackUsage(userId, 'ai_error');
      await this.saveFeedback(submissionId, basicFeedback);
      
      // Store error in Redis
      await redis.set(
        `feedback:error:${submissionId}`, 
        error.message || 'Unknown error', 
        'EX', 
        3600 // 1 hour
      );
      
      return { ...basicFeedback, source: 'basic' };
    } finally {
      // Clear pending status
      await redis.del(`feedback:pending:${submissionId}`);
    }
  }
  
  /**
   * Check status of a feedback generation job
   * @param jobId Job ID from queue
   * @returns Job status and result if completed
   */
  async checkFeedbackJob(jobId: string) {
    const job = await feedbackQueue.getJob(jobId);
    
    if (!job) {
      return {
        status: 'not_found',
        message: 'Job not found'
      };
    }
    
    const state = await job.getState();
    
    if (state === 'completed') {
      return {
        status: 'completed',
        result: job.returnvalue
      };
    }
    
    if (state === 'failed') {
      return {
        status: 'failed',
        error: job.failedReason
      };
    }
    
    return {
      status: state,
      jobId
    };
  }
  
  /**
   * Generate a fingerprint of code for caching
   * @param code Source code
   * @param language Programming language
   * @returns Hash of normalized code
   * @private
   */
  private generateCodeFingerprint(code: string, language: string): string {
    // Normalize code by removing comments, whitespace, variable names
    // This helps find functionally identical submissions with different formatting
    const normalizedCode = code
      .replace(/\/\/.*|\/\*[\s\S]*?\*\//g, '') // Remove comments
      .replace(/\s+/g, ' ')                    // Normalize whitespace
      .trim();
      
    return createHash('sha256')
      .update(`${language}:${normalizedCode}`)
      .digest('hex');
  }
  
  /**
   * Check if feedback is available in cache
   * @param fingerprint Code fingerprint
   * @returns Cached feedback or null
   * @private
   */
  private async checkCache(fingerprint: string): Promise<FeedbackResponse | null> {
    try {
      const cached = await redis.get(`feedback:${fingerprint}`);
      return cached ? JSON.parse(cached) : null;
    } catch (error) {
      logger.error('Cache lookup error', { error });
      return null;
    }
  }
  
  /**
   * Store feedback in cache
   * @param fingerprint Code fingerprint
   * @param feedback Feedback to cache
   * @private
   */
  private async cacheResult(fingerprint: string, feedback: FeedbackResponse): Promise<void> {
    try {
      await redis.set(
        `feedback:${fingerprint}`, 
        JSON.stringify(feedback),
        'EX', 
        60 * 60 * 24 * 30 // 30 days
      );
    } catch (error) {
      logger.error('Cache storage error', { error });
    }
  }
  
  /**
   * Create optimized prompt for AI feedback
   * @param code Source code
   * @param language Programming language
   * @param challenge Challenge details
   * @returns Optimized prompt
   * @private
   */
  private createPrompt(code: string, language: string, challenge: any): string {
    // Optimize code for token usage - trim large comments and unnecessary whitespace
    const trimmedCode = code
      .replace(/\/\*[\s\S]*?\*\//g, '/* comment */') // Replace block comments
      .replace(/(\r\n|\n|\r){2,}/gm, '\n\n');        // Remove excessive newlines
    
    return `
      You are an expert programming instructor providing feedback on student code. Analyze this ${language} code for the following challenge:
      
      Challenge: "${challenge.title}"
      Description: "${challenge.description}"
      Difficulty: ${challenge.difficulty}
      Learning Outcomes: ${challenge.learningOutcomes.join(', ')}
      
      Code to review:
      \`\`\`${language}
      ${trimmedCode}
      \`\`\`
      
      Provide specific, educational feedback in JSON format with these fields:
      - strengths: Array of 2-3 specific strengths of the code
      - improvements: Array of 2-3 specific areas for improvement
      - suggestions: Array of 1-2 actionable code suggestions
      - conceptualErrors: Array of any fundamental misunderstandings (if any, otherwise empty array)
      - score: Number between 0-100 representing overall quality
      
      Your feedback should be constructive, focused on learning, and directly relevant to the challenge requirements.
      Format your response as valid JSON only, with no additional text.
    `;
  }
  
  /**
   * Parse AI response into structured feedback
   * @param response AI response
   * @param processingTime Time taken to process
   * @returns Structured feedback
   * @private
   */
  private parseAIResponse(response: any, processingTime: number): FeedbackResponse {
    try {
      // Parse JSON response
      const parsed = typeof response === 'string' 
        ? JSON.parse(response)
        : response;
      
      // Validate required fields
      if (!parsed.strengths || !parsed.improvements || !parsed.suggestions || typeof parsed.score !== 'number') {
        throw new Error('Invalid AI response format');
      }
      
      return {
        strengths: parsed.strengths,
        improvements: parsed.improvements,
        suggestions: parsed.suggestions,
        conceptualErrors: parsed.conceptualErrors || [],
        score: parsed.score,
        processingTime,
        tokenCount: response.usage?.totalTokens || 500,
        modelUsed: 'gpt-4'
      };
    } catch (error) {
      logger.error('AI response parsing error', { error, response });
      
      // Return generic feedback on parsing error
      return {
        strengths: ['The code is structured in a logical way'],
        improvements: ['Consider adding more detailed comments'],
        suggestions: ['Review your algorithm for edge cases'],
        conceptualErrors: [],
        score: 70,
        processingTime,
        tokenCount: 200,
        modelUsed: 'fallback'
      };
    }
  }
  
  /**
   * Find submissions with similar code
   * @param code Source code
   * @param challengeId Challenge ID
   * @returns Similar feedback or null
   * @private
   */
  private async findSimilarFeedback(code: string, challengeId: string): Promise<FeedbackResponse | null> {
    try {
      // Generate embedding for the code
      const embedding = await aiProvider.generateEmbedding(code);
      
      // Find submissions with similar code using vector similarity
      const similarSubmissions = await prisma.$queryRaw`
        SELECT s.id, f.* 
        FROM "Submission" s
        JOIN "AIFeedback" f ON s.id = f."submissionId"
        WHERE s."challengeId" = ${challengeId}
        AND s.embedding IS NOT NULL
        ORDER BY s.embedding <=> ${embedding}
        LIMIT 1
      `;
      
      if (similarSubmissions && similarSubmissions.length > 0) {
        const feedback = similarSubmissions[0];
        return {
          strengths: feedback.strengths,
          improvements: feedback.improvements,
          suggestions: feedback.suggestions,
          conceptualErrors: feedback.conceptualErrors || [],
          score: feedback.score,
          tokenCount: 0, // No tokens used for similarity match
          modelUsed: 'similarity',
          processingTime: 0
        };
      }
      
      return null;
    } catch (error) {
      logger.error('Similarity search error', { error });
      return null;
    }
  }
  
  /**
   * Store embedding for similarity matching
   * @param submissionId Submission ID
   * @param code Source code
   * @private
   */
  private async storeEmbedding(submissionId: string, code: string): Promise<void> {
    try {
      const embedding = await aiProvider.generateEmbedding(code);
      
      await prisma.submission.update({
        where: { id: submissionId },
        data: { embedding }
      });
    } catch (error) {
      logger.error('Embedding storage error', { error });
    }
  }
  
  /**
   * Check for common code patterns
   * @param code Source code
   * @param language Programming language
   * @param challengeId Challenge ID
   * @returns Pattern matching result
   * @private
   */
  private async analyzePatterns(code: string, language: string, challengeId: string): Promise<PatternResult> {
    // Get common patterns for this challenge/language
    const patterns = await prisma.commonPattern.findMany({
      where: {
        challengeId,
        language
      }
    });
    
    if (patterns.length === 0) {
      return { confidence: 0, feedback: null };
    }
    
    // Check for pattern matches
    const matches = patterns.filter(pattern => {
      const regex = new RegExp(pattern.pattern, 'g');
      return regex.test(code);
    });
    
    if (matches.length > 0) {
      // Calculate confidence based on match ratio
      const confidence = matches.length / patterns.length;
      
      // Build feedback from matched patterns
      const feedback = {
        strengths: matches
          .filter(m => m.type === 'STRENGTH')
          .map(m => m.description),
        improvements: matches
          .filter(m => m.type === 'IMPROVEMENT')
          .map(m => m.description),
        suggestions: matches
          .filter(m => m.type === 'SUGGESTION')
          .map(m => m.description),
        conceptualErrors: [],
        score: this.calculatePatternScore(matches, patterns.length),
        tokenCount: 0,
        modelUsed: 'pattern',
        processingTime: 0
      };
      
      return { confidence, feedback };
    }
    
    return { confidence: 0, feedback: null };
  }
  
  /**
   * Save feedback to database
   * @param submissionId Submission ID
   * @param feedback Feedback to save
   * @private
   */
  private async saveFeedback(submissionId: string, feedback: FeedbackResponse): Promise<void> {
    await prisma.aIFeedback.create({
      data: {
        submissionId,
        strengths: feedback.strengths,
        improvements: feedback.improvements,
        suggestions: feedback.suggestions,
        conceptualErrors: feedback.conceptualErrors || [],
        score: feedback.score,
        tokenCount: feedback.tokenCount,
        source: feedback.source || 'ai',
        modelUsed: feedback.modelUsed,
        processingTime: feedback.processingTime
      }
    });
  }
  
  /**
   * Check if user has remaining token quota
   * @param userId User ID
   * @returns Whether user has quota
   * @private
   */
  private async checkUserQuota(userId: string): Promise<boolean> {
    try {
      // Get user's subscription tier
      const user = await prisma.user.findUnique({
        where: { id: userId },
        select: { 
          role: true,
          totalTokensUsed: true,
          settings: true
        }
      });
      
      if (!user) return false;
      
      // Get today's usage
      const today = new Date().toISOString().split('T')[0];
      const dailyUsage = await prisma.usageLog.aggregate({
        where: {
          userId,
          type: 'ai_feedback',
          timestamp: {
            gte: new Date(today)
          }
        },
        _sum: {
          tokenCount: true
        }
      });
      
      const dailyTokens = dailyUsage._sum.tokenCount || 0;
      
      // Set limits based on role/subscription
      let dailyLimit = 5000; // Default
      
      if (user.role === 'STUDENT') dailyLimit = 10000;
      if (user.role === 'INSTRUCTOR') dailyLimit = 20000;
      if (user.role === 'ADMIN') dailyLimit = 50000;
      
      // Override with specific settings if present
      if (user.settings?.tokenLimit) {
        dailyLimit = user.settings.tokenLimit;
      }
      
      return dailyTokens < dailyLimit;
    } catch (error) {
      logger.error('Quota check error', { error });
      return false; // Fail safe - no quota
    }
  }
  
  /**
   * Track usage for monitoring and billing
   * @param userId User ID
   * @param type Usage type
   * @param tokenCount Token count (for AI usage)
   * @private
   */
  private async trackUsage(userId: string, type: string, tokenCount: number = 0): Promise<void> {
    try {
      // Log usage for analytics
      await prisma.usageLog.create({
        data: {
          userId,
          type,
          tokenCount,
          timestamp: new Date()
        }
      });
      
      // Update total token usage if applicable
      if (tokenCount > 0) {
        await prisma.user.update({
          where: { id: userId },
          data: {
            totalTokensUsed: {
              increment: tokenCount
            }
          }
        });
      }
      
      // Track in Redis for real-time metrics
      const today = new Date().toISOString().split('T')[0];
      await redis.incr(`stats:${type}:${today}`);
      await redis.expire(`stats:${type}:${today}`, 86400 * 7); // 7 days
    } catch (error) {
      logger.error('Usage tracking error', { error });
    }
  }
  
  /**
   * Generate basic feedback without AI
   * @param code Source code
   * @param language Programming language
   * @returns Basic feedback
   * @private
   */
  private generateBasicFeedback(code: string, language: string): FeedbackResponse {
    // Generate language-specific feedback using static analysis
    const basicFeedback: FeedbackResponse = {
      strengths: [],
      improvements: [],
      suggestions: [],
      conceptualErrors: [],
      score: 65, // Default score
      tokenCount: 0,
      modelUsed: 'basic',
      processingTime: 0
    };
    
    // Add some default strengths
    basicFeedback.strengths.push('Your code successfully passes the test cases');
    
    // Add language-specific feedback
    if (language === 'javascript' || language === 'typescript') {
      // Check for consistent style
      if (!code.includes('console.log')) {
        basicFeedback.strengths.push('Code avoids debug console statements in production code');
      } else {
        basicFeedback.improvements.push('Consider removing console.log statements from production code');
      }
      
      // Check for strict equality
      if (code.includes('===')) {
        basicFeedback.strengths.push('Uses strict equality operators for comparison');
      } else if (code.includes('==')) {
        basicFeedback.improvements.push('Consider using strict equality operators (===) instead of loose equality (==)');
      }
      
      // Check for error handling
      if (code.includes('try') && code.includes('catch')) {
        basicFeedback.strengths.push('Implements error handling with try/catch blocks');
      } else if (code.includes('then') && code.includes('catch')) {
        basicFeedback.strengths.push('Implements promise error handling with .catch()');
      } else if (code.includes('async') && !code.includes('try')) {
        basicFeedback.improvements.push('Consider adding error handling for async operations');
      }
      
      // Suggest modern JS features
      if (!code.includes('=>') && !code.includes('function')) {
        basicFeedback.suggestions.push('Consider using arrow functions or named functions for better code organization');
      }
    } else if (language === 'python') {
      // Check for docstrings
      if (code.includes('"""') || code.includes("'''")) {
        basicFeedback.strengths.push('Includes docstrings for documentation');
      } else {
        basicFeedback.improvements.push('Consider adding docstrings to document your code');
      }
      
      // Check for function organization
      if (code.includes('def ')) {
        basicFeedback.strengths.push('Code is organized into functions for better readability');
      } else {
        basicFeedback.suggestions.push('Consider organizing your code into functions for better modularity');
      }
      
      // Check for list comprehensions
      if (code.includes('[') && code.includes('for ') && code.includes(']')) {
        basicFeedback.strengths.push('Uses Pythonic list comprehensions');
      }
      
      // Check for exception handling
      if (code.includes('try:') && code.includes('except ')) {
        basicFeedback.strengths.push('Implements exception handling');
      } else {
        basicFeedback.improvements.push('Consider adding exception handling to make your code more robust');
      }
    }
    
    // Ensure we have at least one suggestion if not already added
    if (basicFeedback.suggestions.length === 0) {
      basicFeedback.suggestions.push('Add comments to explain your approach and any complex logic');
    }
    
    // Ensure we have at least two strengths
    if (basicFeedback.strengths.length < 2) {
      basicFeedback.strengths.push('Solution demonstrates understanding of the core problem');
    }
    
    // Ensure we have at least one improvement
    if (basicFeedback.improvements.length === 0) {
      basicFeedback.improvements.push('Consider reviewing your code for opportunities to improve efficiency');
    }
    
    return basicFeedback;
  }
  
  /**
   * Calculate score based on pattern matches
   * @param matches Matched patterns
   * @param totalPatterns Total patterns
   * @returns Score between 0-100
   * @private
   */
  private calculatePatternScore(matches, totalPatterns): number {
    const baseScore = 60;
    
    // Calculate score adjustments
    const strengthPoints = matches
      .filter(m => m.type === 'STRENGTH')
      .length * 10;
    
    const improvementPoints = matches
      .filter(m => m.type === 'IMPROVEMENT')
      .length * -5;
    
    // Ensure score is within 0-100 range
    return Math.min(100, Math.max(0, baseScore + strengthPoints + improvementPoints));
  }
}

// Process queue jobs
feedbackQueue.process(async (job) => {
  const service = new AIFeedbackService();
  return service.generateFeedback({...job.data, urgent: true});
});

// Register queue events for monitoring
feedbackQueue.on('completed', (job) => {
  logger.info('Feedback job completed', { jobId: job.id });
});

feedbackQueue.on('failed', (job, error) => {
  logger.error('Feedback job failed', { jobId: job.id, error });
});

// Define types
interface FeedbackRequest {
  submissionId: string;
  userId: string;
  code: string;
  language: string;
  challengeId: string;
  urgent?: boolean;
  subscriptionTier?: string;
}

interface FeedbackResponse {
  strengths: string[];
  improvements: string[];
  suggestions: string[];
  conceptualErrors?: string[];
  score: number;
  tokenCount: number;
  modelUsed: string;
  processingTime?: number;
  source?: string;
}

interface PatternResult {
  confidence: number;
  feedback: FeedbackResponse | null;
}

export const aiFeedbackService = new AIFeedbackService();
```

### 8.3 AI Provider Implementation

```typescript
// lib/ai-provider.ts
import { Configuration, OpenAIApi } from 'openai';
import { logger } from './logger';

// Configuration for OpenAI
const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
});

const openai = new OpenAIApi(configuration);

// AI Provider abstraction to support multiple providers
export class AIProvider {
  /**
   * Generate feedback using AI
   * @param prompt Prompt to send to AI
   * @param options Options for the AI request
   * @returns AI response
   */
  async generateFeedback(prompt: string, options: AIOptions = {}): Promise<any> {
    const {
      model = 'gpt-4',
      temperature = 0.3,
      maxTokens = 800,
      timeout = 15000
    } = options;
    
    try {
      // Set timeout for API call
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), timeout);
      
      // Call OpenAI API
      const response = await openai.createChatCompletion(
        {
          model,
          messages: [
            {
              role: 'system',
              content: 'You are an expert programming instructor providing feedback on student code.'
            },
            {
              role: 'user',
              content: prompt
            }
          ],
          temperature,
          max_tokens: maxTokens,
          n: 1,
          stop: null
        },
        { signal: controller.signal }
      );
      
      // Clear timeout
      clearTimeout(timeoutId);
      
      // Extract content from response
      const responseText = response.data.choices[0].message.content.trim();
      
      // Add token usage information
      const result = {
        ...responseText,
        usage: {
          totalTokens: response.data.usage.total_tokens,
          promptTokens: response.data.usage.prompt_tokens,
          completionTokens: response.data.usage.completion_tokens
        }
      };
      
      return result;
    } catch (error) {
      logger.error('AI API error', { error, model });
      
      // Handle specific error types
      if (error.name === 'AbortError') {
        throw new Error('AI request timed out');
      } else if (error.response) {
        throw new Error(`AI API error: ${error.response.data.error.message}`);
      } else {
        throw new Error(`AI error: ${error.message}`);
      }
    }
  }
  
  /**
   * Generate embedding vector for text
   * @param text Text to generate embedding for
   * @returns Embedding vector
   */
  async generateEmbedding(text: string): Promise<number[]> {
    try {
      // Truncate text if too long (context limit)
      const truncatedText = text.slice(0, 8000);
      
      // Call OpenAI embedding API
      const response = await openai.createEmbedding({
        model: 'text-embedding-ada-002',
        input: truncatedText
      });
      
      // Extract embedding
      return response.data.data[0].embedding;
    } catch (error) {
      logger.error('Embedding generation error', { error });
      throw new Error(`Embedding error: ${error.message}`);
    }
  }
}

interface AIOptions {
  model?: string;
  temperature?: number;
  maxTokens?: number;
  timeout?: number;
}

export const aiProvider = new AIProvider();
```

### 8.4 Feedback Display Component

```tsx
// components/feedback/feedback-panel.tsx
'use client';

import { useEffect, useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { getSubmissionFeedback, regenerateFeedback } from '@/lib/api/submissions';
import { Button } from '../ui/button';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '../ui/tabs';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '../ui/card';
import { Alert, AlertDescription, AlertTitle } from '../ui/alert';
import { Skeleton } from '../ui/skeleton';
import { InfoCircledIcon, ReloadIcon, RocketIcon, CrossCircledIcon, CheckCircledIcon } from '@radix-ui/react-icons';
import { AIFeedback } from '@/types';

interface FeedbackPanelProps {
  submissionId: string;
}

/**
 * Component to display AI feedback for a submission
 */
export function FeedbackPanel({ submissionId }: FeedbackPanelProps) {
  const [activeTab, setActiveTab] = useState('strengths');
  const [isRegenerating, setIsRegenerating] = useState(false);
  const [jobId, setJobId] = useState<string | null>(null);
  const [pollInterval, setPollInterval] = useState<number | null>(null);
  
  // Fetch feedback
  const { 
    data, 
    isLoading, 
    error, 
    refetch 
  } = useQuery({
    queryKey: ['feedback', submissionId],
    queryFn: () => getSubmissionFeedback(submissionId),
    refetchInterval: jobId ? 2000 : false, // Poll every 2 seconds when waiting for job
    refetchOnWindowFocus: !jobId // Don't refetch on focus when polling for job
  });
  
  // Handle job polling
  useEffect(() => {
    if (data?.status === 'pending' && jobId) {
      // Already polling via refetchInterval
    } else if (data?.status === 'pending' && !jobId && data?.jobId) {
      // Start polling with jobId from response
      setJobId(data.jobId);
    } else if (data?.status === 'completed' && jobId) {
      // Job completed, stop polling
      setJobId(null);
    }
  }, [data, jobId]);
  
  // Handle regeneration
  const handleRegenerate = async () => {
    if (isRegenerating) return;
    
    try {
      setIsRegenerating(true);
      const result = await regenerateFeedback(submissionId);
      setJobId(result.jobId);
      
      // Force refetch to get pending status
      refetch();
    } catch (error) {
      console.error('Failed to regenerate feedback:', error);
    } finally {
      setIsRegenerating(false);
    }
  };
  
  // Display different content based on feedback status
  if (isLoading) {
    return <FeedbackSkeleton />;
  }
  
  if (error) {
    return (
      <Alert variant="destructive">
        <CrossCircledIcon className="h-4 w-4" />
        <AlertTitle>Error</AlertTitle>
        <AlertDescription>
          Failed to load feedback. Please try again later.
        </AlertDescription>
      </Alert>
    );
  }
  
  // Pending feedback
  if (data.status === 'pending') {
    return (
      <Alert>
        <ReloadIcon className="h-4 w-4 animate-spin" />
        <AlertTitle>Generating Feedback</AlertTitle>
        <AlertDescription>
          Your code is being analyzed. This may take up to 30 seconds.
        </AlertDescription>
      </Alert>
    );
  }
  
  // Error generating feedback
  if (data.status === 'error') {
    return (
      <Alert variant="destructive">
        <CrossCircledIcon className="h-4 w-4" />
        <AlertTitle>Feedback Error</AlertTitle>
        <AlertDescription>
          {data.message || 'An error occurred while generating feedback.'}
          <Button 
            variant="outline" 
            size="sm" 
            className="mt-2"
            onClick={handleRegenerate}
            disabled={isRegenerating}
          >
            {isRegenerating ? 'Regenerating...' : 'Regenerate Feedback'}
          </Button>
        </AlertDescription>
      </Alert>
    );
  }
  
  // Feedback ready
  const feedback = data.feedback as AIFeedback;
  
  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <div className="flex items-center space-x-2">
          <h3 className="text-lg font-semibold">AI Feedback</h3>
          <span className="text-sm text-muted-foreground">
            Score: {feedback.score}/100
          </span>
        </div>
        
        <Button 
          variant="outline" 
          size="sm"
          onClick={handleRegenerate}
          disabled={isRegenerating}
        >
          {isRegenerating ? (
            <>
              <ReloadIcon className="mr-2 h-4 w-4 animate-spin" />
              Regenerating
            </>
          ) : (
            <>
              <ReloadIcon className="mr-2 h-4 w-4" />
              Regenerate
            </>
          )}
        </Button>
      </div>
      
      <Tabs defaultValue="strengths" value={activeTab} onValueChange={setActiveTab}>
        <TabsList className="grid grid-cols-3">
          <TabsTrigger value="strengths">
            <CheckCircledIcon className="mr-2 h-4 w-4" />
            Strengths
          </TabsTrigger>
          <TabsTrigger value="improvements">
            <InfoCircledIcon className="mr-2 h-4 w-4" />
            Improvements
          </TabsTrigger>
          <TabsTrigger value="suggestions">
            <RocketIcon className="mr-2 h-4 w-4" />
            Suggestions
          </TabsTrigger>
        </TabsList>
        
        <TabsContent value="strengths" className="mt-4">
          <Card>
            <CardHeader>
              <CardTitle>Code Strengths</CardTitle>
              <CardDescription>
                What your code does well
              </CardDescription>
            </CardHeader>
            <CardContent>
              <ul className="space-y-2">
                {feedback.strengths.map((strength, index) => (
                  <li key={index} className="flex items-start">
                    <CheckCircledIcon className="mr-2 h-5 w-5 text-green-500 mt-0.5" />
                    <span>{strength}</span>
                  </li>
                ))}
              </ul>
            </CardContent>
          </Card>
        </TabsContent>
        
        <TabsContent value="improvements" className="mt-4">
          <Card>
            <CardHeader>
              <CardTitle>Areas for Improvement</CardTitle>
              <CardDescription>
                What could be improved in your solution
              </CardDescription>
            </CardHeader>
            <CardContent>
              <ul className="space-y-2">
                {feedback.improvements.map((improvement, index) => (
                  <li key={index} className="flex items-start">
                    <InfoCircledIcon className="mr-2 h-5 w-5 text-amber-500 mt-0.5" />
                    <span>{improvement}</span>
                  </li>
                ))}
              </ul>
            </CardContent>
          </Card>
        </TabsContent>
        
        <TabsContent value="suggestions" className="mt-4">
          <Card>
            <CardHeader>
              <CardTitle>Code Suggestions</CardTitle>
              <CardDescription>
                Specific recommendations to enhance your code
              </CardDescription>
            </CardHeader>
            <CardContent>
              <ul className="space-y-2">
                {feedback.suggestions.map((suggestion, index) => (
                  <li key={index} className="flex items-start">
                    <RocketIcon className="mr-2 h-5 w-5 text-blue-500 mt-0.5" />
                    <span>{suggestion}</span>
                  </li>
                ))}
              </ul>
              
              {feedback.conceptualErrors && feedback.conceptualErrors.length > 0 && (
                <div className="mt-4 p-3 bg-red-50 dark:bg-red-950 rounded-md border border-red-200 dark:border-red-800">
                  <h4 className="font-semibold text-red-700 dark:text-red-300 mb-2">
                    Conceptual Misunderstandings
                  </h4>
                  <ul className="space-y-1">
                    {feedback.conceptualErrors.map((error, index) => (
                      <li key={index} className="flex items-start">
                        <CrossCircledIcon className="mr-2 h-4 w-4 text-red-500 mt-0.5" />
                        <span className="text-sm">{error}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
      
      <div className="text-xs text-muted-foreground mt-2 flex items-center justify-between">
        <div>
          Feedback generated using {feedback.modelUsed}
        </div>
        <div>
          Source: {feedback.source}
        </div>
      </div>
    </div>
  );
}

// Loading skeleton
function FeedbackSkeleton() {
  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <Skeleton className="h-6 w-40" />
        <Skeleton className="h-9 w-28" />
      </div>
      
      <div className="h-10 flex space-x-1">
        <Skeleton className="flex-1" />
        <Skeleton className="flex-1" />
        <Skeleton className="flex-1" />
      </div>
      
      <div className="space-y-2">
        <Skeleton className="h-4 w-full" />
        <Skeleton className="h-4 w-full" />
        <Skeleton className="h-4 w-3/4" />
        <Skeleton className="h-4 w-5/6" />
      </div>
    </div>
  );
}
```

## 9. Code Execution Environment

### 9.1 Secure Execution Architecture

```mermaid
graph TD
    A[Submission] --> B[Submission Service]
    B --> C[Execution Queue]
    C --> D[Execution Worker]
    D --> E[Docker Container]
    E --> F[Language Runtime]
    F --> G[Sandboxed Execution]
    G --> H[Test Runner]
    H --> I[Results Collection]
    I --> J[Execution Worker]
    J --> K[Submission Service]
    
    subgraph Security Measures
        L[Memory Limits]
        M[CPU Limits]
        N[Network Isolation]
        O[Process Limits]
        P[Filesystem Restrictions]
        Q[Execution Timeouts]
    end
    
    E --> L
    E --> M
    E --> N
    E --> O
    E --> P
    D --> Q
```

### 9.2 Code Executor Service Implementation

```typescript
// services/code-executor.service.ts
import Docker from 'dockerode';
import fs from 'fs/promises';
import path from 'path';
import { v4 as uuidv4 } from 'uuid';
import { Queue } from 'bull';
import { logger } from '../lib/logger';
import { redis } from '../lib/redis';

// Create Docker client
const docker = new Docker();

// Set up execution queue
const executionQueue = new Queue('code-execution', {
  redis: {
    host: process.env.REDIS_HOST,
    port: parseInt(process.env.REDIS_PORT || '6379')
  },
  defaultJobOptions: {
    attempts: 2,
    timeout: 30000,
    removeOnComplete: true
  }
});

export class CodeExecutorService {
  /**
   * Execute code with test cases
   * @param request Execution request parameters
   * @returns Execution result or job ID
   */
  async executeCode(request: ExecutionRequest): Promise<ExecutionResult> {
    // Apply rate limiting
    if (request.userId) {
      const rateLimitKey = `ratelimit:code-execution:${request.userId}`;
      const currentRequests = await redis.incr(rateLimitKey);
      
      // Set expiry if this is the first request in the window
      if (currentRequests === 1) {
        await redis.expire(rateLimitKey, 60); // 1 minute window
      }
      
      // Check if rate limit exceeded (10 executions per minute)
      if (currentRequests > 10) {
        return {
          status: 'error',
          error: 'Rate limit exceeded. Please try again later.'
        };
      }
    }
    
    // For asynchronous execution, queue the job and return ID
    if (!request.sync) {
      const job = await executionQueue.add(request, {
        attempts: 2,
        timeout: 15000, // 15 seconds
        removeOnComplete: true
      });
      
      return {
        jobId: job.id.toString(),
        status: 'queued'
      };
    }
    
    // Otherwise, run execution directly
    return this.runExecution(request);
  }
  
  /**
   * Get status and result of an execution job
   * @param jobId Job ID
   * @returns Current status and result if available
   */
  async getExecutionResult(jobId: string): Promise<ExecutionResult> {
    const job = await executionQueue.getJob(jobId);
    
    if (!job) {
      return {
        status: 'error',
        error: 'Job not found'
      };
    }
    
    const state = await job.getState();
    
    if (state === 'completed') {
      return job.returnvalue as ExecutionResult;
    }
    
    if (state === 'failed') {
      return {
        status: 'error',
        error: job.failedReason
      };
    }
    
    return {
      status: state as any,
      jobId: job.id.toString()
    };
  }
  
  /**
   * Run code execution in a secure container
   * @param request Execution request
   * @returns Execution result
   * @private
   */
  private async runExecution(request: ExecutionRequest): Promise<ExecutionResult> {
    const { code, language, testCases, timeout = 10000 } = request;
    
    // Generate unique execution ID
    const executionId = uuidv4();
    const containerName = `code-execution-${executionId}`;
    
    // Create temporary directory for code files
    const tempDir = path.join(process.env.TEMP_DIR || '/tmp', executionId);
    await fs.mkdir(tempDir, { recursive: true });
    
    try {
      // Get language-specific configuration
      const config = this.getLanguageConfig(language);
      
      // Write code and test files
      await fs.writeFile(path.join(tempDir, config.mainFile), code);
      await fs.writeFile(
        path.join(tempDir, config.testFile), 
        config.generateTestCode(code, testCases)
      );
      
      // Create and start container with strict security limits
      const container = await docker.createContainer({
        Image: config.image,
        name: containerName,
        Cmd: config.runCommand,
        HostConfig: {
          Binds: [`${tempDir}:/app`],
          Memory: 256 * 1024 * 1024, // 256MB limit
          MemorySwap: 256 * 1024 * 1024, // No swap
          NanoCpus: 500000000, // 0.5 CPU
          NetworkMode: 'none', // No network access
          ReadonlyRootfs: true,
          Mounts: [{
            Target: '/app',
            Source: tempDir,
            Type: 'bind',
            ReadOnly: false
          }],
          SecurityOpt: ['no-new-privileges'],
          PidsLimit: 50, // Prevent fork bombs
        },
        WorkingDir: '/app',
        StopTimeout: 10,
      });
      
      // Start the container with timeout
      await container.start();
      
      let timedOut = false;
      const executionTimeout = setTimeout(async () => {
        timedOut = true;
        try {
          await container.stop();
        } catch (e) {
          logger.error('Error stopping container', { error: e, containerId: containerName });
        }
      }, timeout);
      
      // Wait for container to finish
      const output = await container.wait();
      clearTimeout(executionTimeout);
      
      // Get container logs
      const logs = await container.logs({
        stdout: true,
        stderr: true,
        follow: false,
      });
      
      // Process and return results
      const outputString = logs.toString();
      
      if (timedOut) {
        logger.warn('Code execution timed out', { 
          language,
          containerId: containerName,
          executionId
        });
        
        return {
          status: 'error',
          error: 'Execution timed out',
          executionTime: timeout
        };
      } else if (output.StatusCode !== 0) {
        logger.info('Code execution failed', {
          language,
          exitCode: output.StatusCode,
          containerId: containerName,
          executionId
        });
        
        return {
          status: 'error',
          error: this.formatErrorOutput(outputString) || 'Execution failed',
          executionTime: 0
        };
      } else {
        // Parse test results
        try {
          const result = this.parseTestResults(outputString, config);
          
          logger.info('Code execution completed', {
            language,
            executionId,
            status: result.status,
            executionTime: result.executionTime,
            allTestsPassing: result.allTestsPassing
          });
          
          return result;
        } catch (error) {
          logger.error('Result parsing error', {
            error: error.message,
            output: outputString,
            executionId
          });
          
          return {
            status: 'error',
            error: 'Failed to parse execution results',
            executionTime: 0
          };
        }
      }
    } catch (error) {
      logger.error('Code execution error', { 
        error: error.message,
        language,
        executionId 
      });
      
      return {
        status: 'error',
        error: `Execution error: ${error.message}`,
        executionTime: 0
      };
    } finally {
      // Cleanup: Remove container and temporary files
      try {
        const container = docker.getContainer(containerName);
        await container.remove({ force: true });
      } catch (e) {
        // Ignore errors if container doesn't exist
      }
      
      try {
        await fs.rm(tempDir, { recursive: true, force: true });
      } catch (e) {
        logger.error('Error removing temp directory', { 
          error: e.message,
          dir: tempDir
        });
      }
    }
  }
  
  /**
   * Get configuration for a programming language
   * @param language Programming language
   * @returns Language configuration
   * @private
   */
  private getLanguageConfig(language: string): LanguageConfig {
    const configs: Record<string, LanguageConfig> = {
      javascript: {
        image: 'node:18-alpine',
        mainFile: 'solution.js',
        testFile: 'test.js',
        runCommand: ['node', 'test.js'],
        generateTestCode: (code, testCases) => {
          return `
            const vm = require('vm2').VM;
            
            // Wrap solution code in a module
            const solution = \`${code.replace(/`/g, '\\`')}\`;
            
            // Create a sandboxed environment
            const sandbox = new vm({
              timeout: 5000,
              sandbox: {},
              eval: false,
              wasm: false
            });
            
            try {
              // Execute code in sandbox
              const userModule = { exports: {} };
              sandbox.run(\`
                (function(module) {
                  ${solution}
                })(module);
              \`, 'solution.js');
              
              // Get exported functions
              const userFunctions = userModule.exports;
              
              // Run test cases
              const testResults = [];
              let allPassed = true;
              const startTime = Date.now();
              
              ${testCases.map((test, i) => `
                try {
                  const result = userFunctions.${test.functionName}(${test.input});
                  const expected = ${test.expectedOutput};
                  const passed = JSON.stringify(result) === JSON.stringify(expected);
                  
                  testResults.push({
                    id: ${i},
                    description: "${test.description}",
                    input: "${test.input}",
                    expectedOutput: "${test.expectedOutput}",
                    actualOutput: JSON.stringify(result),
                    passed
                  });
                  
                  if (!passed) allPassed = false;
                } catch (e) {
                  testResults.push({
                    id: ${i},
                    description: "${test.description}",
                    input: "${test.input}",
                    expectedOutput: "${test.expectedOutput}",
                    error: e.message,
                    passed: false
                  });
                  
                  allPassed = false;
                }
              `).join('\n')}
              
              const executionTime = Date.now() - startTime;
              
              // Output results as JSON
              console.log(JSON.stringify({
                status: allPassed ? 'passed' : 'failed',
                testResults,
                executionTime,
                allTestsPassing: allPassed,
                memoryUsed: process.memoryUsage().heapUsed / 1024
              }));
            } catch (e) {
              console.log(JSON.stringify({
                status: 'error',
                error: e.message
              }));
            }
          `;
        }
      },
      python: {
        image: 'python:3.10-alpine',
        mainFile: 'solution.py',
        testFile: 'test.py',
        runCommand: ['python', 'test.py'],
        generateTestCode: (code, testCases) => {
          return `
            import json
            import sys
            import resource
            from io import StringIO
            import traceback
            
            # Set resource limits
            resource.setrlimit(resource.RLIMIT_CPU, (5, 5))
            
            # Save solution code
            solution_code = '''${code.replace(/'/g, "\\'")}'''
            
            try:
                # Redirect stdout to capture print statements
                original_stdout = sys.stdout
                sys.stdout = StringIO()
                
                # Execute code in a namespace
                solution_namespace = {}
                exec(solution_code, solution_namespace)
                
                # Restore stdout
                printed_output = sys.stdout.getvalue()
                sys.stdout = original_stdout
                
                # Run test cases
                test_results = []
                all_passed = True
                import time
                start_time = time.time()
                
                ${testCases.map((test, i) => `
                try:
                    result = solution_namespace['${test.functionName}'](${test.input})
                    expected = ${test.expectedOutput}
                    passed = result == expected
                    
                    test_results.append({
                        'id': ${i},
                        'description': "${test.description}",
                        'input': "${test.input}",
                        'expectedOutput': "${test.expectedOutput}",
                        'actualOutput': str(result),
                        'passed': passed
                    })
                    
                    if not passed:
                        all_passed = False
                except Exception as e:
                    test_results.append({
                        'id': ${i},
                        'description': "${test.description}",
                        'input': "${test.input}",
                        'expectedOutput': "${test.expectedOutput}",
                        'error': str(e),
                        'passed': False
                    })
                    all_passed = False
                `).join('\n')}
                
                execution_time = int((time.time() - start_time) * 1000)
                memory_used = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
                
                # Output results as JSON
                print(json.dumps({
                    'status': 'passed' if all_passed else 'failed',
                    'testResults': test_results,
                    'executionTime': execution_time,
                    'memoryUsed': memory_used,
                    'allTestsPassing': all_passed
                }))
            except Exception as e:
                print(json.dumps({
                    'status': 'error',
                    'error': str(e),
                    'traceback': traceback.format_exc()
                }))
          `;
        }
      },
      // Other language configurations would go here
    };
    
    // Default to JavaScript if language not supported
    return configs[language] || configs.javascript;
  }
  
  /**
   * Parse test results from container output
   * @param output Container output
   * @param config Language configuration
   * @returns Structured execution result
   * @private
   */
  private parseTestResults(output: string, config: LanguageConfig): ExecutionResult {
    // Find JSON in output (ignoring any other text)
    const jsonMatch = output.match(/\{[\s\S]*\}/);
    if (!jsonMatch) {
      return {
        status: 'error',
        error: 'No valid JSON output found',
        executionTime: 0
      };
    }
    
    const json = JSON.parse(jsonMatch[0]);
    
    if (json.status === 'error') {
      return {
        status: 'error',
        error: json.error,
        executionTime: 0
      };
    }
    
    // Calculate score based on passing tests
    const totalTests = json.testResults.length;
    const passingTests = json.testResults.filter(t => t.passed).length;
    const score = totalTests > 0 ? (passingTests / totalTests) * 100 : 0;
    
    return {
      status: json.status,
      testResults: json.testResults,
      executionTime: json.executionTime,
      memoryUsed: json.memoryUsed,
      allTestsPassing: json.allTestsPassing,
      score
    };
  }
  
  /**
   * Format error output to be more user-friendly
   * @param output Error output from container
   * @returns Formatted error message
   * @private
   */
  private formatErrorOutput(output: string): string {
    // Try to parse as JSON
    try {
      const jsonMatch = output.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        const json = JSON.parse(jsonMatch[0]);
        return json.error || output;
      }
    } catch (e) {
      // Ignore parsing errors
    }
    
    // Find common error patterns
    const syntaxErrorMatch = output.match(/SyntaxError: (.*)/);
    if (syntaxErrorMatch) {
      return `Syntax Error: ${syntaxErrorMatch[1]}`;
    }
    
    const referenceErrorMatch = output.match(/ReferenceError: (.*)/);
    if (referenceErrorMatch) {
      return `Reference Error: ${referenceErrorMatch[1]}`;
    }
    
    // Limit length for very long output
    if (output.length > 500) {
      return output.substring(0, 500) + '...';
    }
    
    return output;
  }
}

// Process jobs from the execution queue
executionQueue.process(async (job) => {
  const service = new CodeExecutorService();
  return service.runExecution(job.data);
});

// Register queue events for monitoring
executionQueue.on('completed', (job) => {
  logger.info('Execution job completed', { jobId: job.id });
});

executionQueue.on('failed', (job, error) => {
  logger.error('Execution job failed', { jobId: job.id, error });
});

// Define types
interface ExecutionRequest {
  code: string;
  language: string;
  testCases: TestCase[];
  timeout?: number;
  sync?: boolean;
  userId?: string;
}

interface TestCase {
  id?: number;
  description: string;
  functionName: string;
  input: string;
  expectedOutput: string;
  isPublic?: boolean;
}

interface ExecutionResult {
  status: 'passed' | 'failed' | 'error' | 'queued' | 'active' | 'waiting';
  testResults?: TestResult[];
  executionTime?: number;
  memoryUsed?: number;
  allTestsPassing?: boolean;
  error?: string;
  jobId?: string;
  score?: number;
}

interface TestResult {
  id: number;
  description: string;
  input: string;
  expectedOutput: string;
  actualOutput?: string;
  error?: string;
  passed: boolean;
}

interface LanguageConfig {
  image: string;
  mainFile: string;
  testFile: string;
  runCommand: string[];
  generateTestCode: (code: string, testCases: TestCase[]) => string;
}

export const codeExecutorService = new CodeExecutorService();
```

### 9.3 Docker Configuration for Language Environments

Each language has a specific Docker environment with appropriate security measures:

#### JavaScript Environment

```dockerfile
# Dockerfile for JavaScript execution
FROM node:18-alpine

# Install VM2 for secure code execution
RUN npm install -g vm2@3.9.19

# Create a non-root user
RUN addgroup -S codeuser && adduser -S -G codeuser codeuser

# Set up working directory
WORKDIR /app

# Set permissions
RUN chown -R codeuser:codeuser /app

# Switch to non-root user
USER codeuser

# Container is configured to run test.js by default
CMD ["node", "test.js"]
```

#### Python Environment

```dockerfile
# Dockerfile for Python execution
FROM python:3.10-alpine

# Create a non-root user
RUN addgroup -S codeuser && adduser -S -G codeuser codeuser

# Set up working directory
WORKDIR /app

# Set permissions
RUN chown -R codeuser:codeuser /app

# Switch to non-root user
USER codeuser

# Container is configured to run test.py by default
CMD ["python", "test.py"]
```

## 10. Security Architecture

### 10.1 Authentication and Authorization

#### 10.1.1 Multi-Layer Authentication

The system implements multiple layers of authentication:

1. **Email/Password Authentication**:
   - Secure password hashing with bcrypt
   - Rate limiting for login attempts
   - Password validation requirements
   - Account lockout after multiple failed attempts

2. **OAuth Integration**:
   - GitHub OAuth for developers
   - Google OAuth for broad accessibility
   - Support for email linking with social accounts

3. **JWT Implementation**:
   - Short-lived JWTs (24-hour expiration)
   - Refresh token rotation
   - Token revocation capabilities
   - Secure cookie storage with HttpOnly flag

#### 10.1.2 Role-Based Access Control (RBAC)

```typescript
// Role-based authorization middleware
export const authorize = (roles: string[]) => {
  return (req: AuthRequest, res: Response, next: NextFunction) => {
    if (!req.user) {
      throw new UnauthorizedError('Authentication required');
    }
    
    if (!roles.includes(req.user.role)) {
      logger.warn('Unauthorized access attempt', { 
        userId: req.user.id, 
        role: req.user.role, 
        requiredRoles: roles,
        path: req.path
      });
      
      throw new ForbiddenError('Insufficient permissions');
    }
    
    next();
  };
};

// Resource ownership verification middleware
export const verifyOwnership = (resourceType: string, paramName: string = 'id') => {
  return async (req: AuthRequest, res: Response, next: NextFunction) => {
    if (!req.user) {
      throw new UnauthorizedError('Authentication required');
    }
    
    // Admin can access any resource
    if (req.user.role === 'ADMIN') {
      return next();
    }
    
    const resourceId = req.params[paramName];
    
    if (!resourceId) {
      throw new BadRequestError(`No ${paramName} provided`);
    }
    
    try {
      let isOwner = false;
      
      // Check ownership based on resource type
      switch (resourceType) {
        case 'challenge':
          const challenge = await prisma.challenge.findUnique({
            where: { id: resourceId },
            select: { createdById: true }
          });
          isOwner = challenge?.createdById === req.user.id;
          break;
        
        case 'submission':
          const submission = await prisma.submission.findUnique({
            where: { id: resourceId },
            select: { userId: true }
          });
          isOwner = submission?.userId === req.user.id;
          break;
        
        case 'course':
          const course = await prisma.course.findUnique({
            where: { id: resourceId },
            select: { instructorId: true }
          });
          isOwner = course?.instructorId === req.user.id;
          break;
          
        default:
          throw new Error(`Unknown resource type: ${resourceType}`);
      }
      
      if (!isOwner) {
        logger.warn('Unauthorized resource access', { 
          userId: req.user.id,
          resourceType,
          resourceId,
          path: req.path
        });
        
        throw new ForbiddenError('You do not have permission to access this resource');
      }
      
      next();
    } catch (error) {
      next(error);
    }
  };
};
```

### 10.2 Data Protection

#### 10.2.1 Data Encryption

1. **Data in Transit**:
   - HTTPS for all API communications using TLS 1.3
   - Secure WebSockets with TLS for real-time features
   - HTTP Strict Transport Security headers

2. **Data at Rest**:
   - Encryption of sensitive database fields
   - Encrypted storage volumes
   - Appropriate key management

#### 10.2.2 Secure Access Controls

1. **Database Security**:
   - Parameterized queries via Prisma to prevent SQL injection
   - Least privilege database users
   - Network-level database isolation

2. **API Security**:
   - Input validation for all parameters
   - Request throttling and rate limiting
   - Content Security Policy headers

### 10.3 Secure Code Execution

The code execution environment is designed with multiple security layers:

1. **Container Isolation**:
   - Docker containers with restricted capabilities
   - Memory and CPU limits
   - No network access
   - Process count limits
   - Read-only filesystem

2. **Language-Specific Sandboxing**:
   - JavaScript: VM2 module for additional isolation
   - Python: Resource limiting and restricted imports
   - Java: SecurityManager for JVM restrictions

3. **Execution Monitoring**:
   - Strict timeouts for all executions
   - Resource usage tracking
   - Automated container cleanup

### 10.4 Vulnerability Management

1. **Dependency Scanning**:
   - Automated scanning in CI/CD pipeline
   - Regular dependency updates
   - GitHub dependency alerts

2. **Code Scanning**:
   - Static code analysis
   - Security linting
   - Code review requirements

3. **Penetration Testing**:
   - Regular security testing
   - Vulnerability disclosure program
   - Bug bounty program (future)

### 10.5 Advanced Threat Protection

The platform employs a multi-layered approach to detect and mitigate sophisticated security threats:

#### 10.5.1 Sandbox Escape Detection

## 11. [Error Handling and Logging]

### 11.1 Error Handling Strategy

The application implements a consistent error handling strategy:

```typescript
// lib/errors.ts
export class AppError extends Error {
  public statusCode: number;
  public code: string;
  public details?: any;
  
  constructor(message: string, statusCode: number, code: string, details?: any) {
    super(message);
    this.name = this.constructor.name;
    this.statusCode = statusCode;
    this.code = code;
    this.details = details;
    
    // Capture stack trace
    Error.captureStackTrace(this, this.constructor);
  }
}

// 400 Bad Request
export class BadRequestError extends AppError {
  constructor(message: string = 'Bad request', details?: any) {
    super(message, 400, 'BAD_REQUEST', details);
  }
}

// 401 Unauthorized
export class UnauthorizedError extends AppError {
  constructor(message: string = 'Unauthorized') {
    super(message, 401, 'UNAUTHORIZED');
  }
}

// 403 Forbidden
export class ForbiddenError extends AppError {
  constructor(message: string = 'Forbidden') {
    super(message, 403, 'FORBIDDEN');
  }
}

// 404 Not Found
export class NotFoundError extends AppError {
  constructor(message: string = 'Resource not found') {
    super(message, 404, 'NOT_FOUND');
  }
}

// 409 Conflict
export class ConflictError extends AppError {
  constructor(message: string = 'Resource conflict') {
    super(message, 409, 'CONFLICT');
  }
}

// 422 Unprocessable Entity
export class ValidationError extends AppError {
  constructor(message: string = 'Validation error', details?: any) {
    super(message, 422, 'VALIDATION_ERROR', details);
  }
}

// 429 Too Many Requests
export class TooManyRequestsError extends AppError {
  constructor(message: string = 'Too many requests') {
    super(message, 429, 'TOO_MANY_REQUESTS');
  }
}

// 500 Internal Server Error
export class InternalServerError extends AppError {
  constructor(message: string = 'Internal server error') {
    super(message, 500, 'INTERNAL_SERVER_ERROR');
  }
}

// Execution-specific error
export class ExecutionError extends AppError {
  constructor(message: string = 'Code execution error') {
    super(message, 400, 'EXECUTION_ERROR');
  }
}
```

### 11.2 Error Handling Middleware

```typescript
// middleware/error.middleware.ts
import { Request, Response, NextFunction } from 'express';
import { AppError } from '../lib/errors';
import { logger } from '../lib/logger';
import { ZodError } from 'zod';

export function errorHandler(err: any, req: Request, res: Response, next: NextFunction) {
  // Default to 500 internal server error
  let statusCode = 500;
  let message = 'Internal server error';
  let code = 'INTERNAL_ERROR';
  let details = undefined;
  
  // Handle AppError instances
  if (err instanceof AppError) {
    statusCode = err.statusCode;
    message = err.message;
    code = err.code;
    details = err.details;
  }
  // Handle Zod validation errors
  else if (err instanceof ZodError) {
    statusCode = 400;
    message = 'Validation error';
    code = 'VALIDATION_ERROR';
    details = err.errors.map(e => ({
      path: e.path.join('.'),
      message: e.message
    }));
  }
  // Handle Prisma errors
  else if (err.code && err.code.startsWith('P')) {
    statusCode = 400;
    
    // Handle common Prisma errors
    switch (err.code) {
      case 'P2002':
        statusCode = 409;
        message = `Unique constraint violation on: ${err.meta?.target}`;
        code = 'UNIQUE_CONSTRAINT';
        break;
      case 'P2025':
        statusCode = 404;
        message = 'Record not found';
        code = 'RECORD_NOT_FOUND';
        break;
      default:
        message = 'Database error';
        code = 'DATABASE_ERROR';
    }
  }
  
  // Log error with appropriate level
  if (statusCode >= 500) {
    logger.error('Server error', {
      error: err,
      path: req.path,
      method: req.method,
      query: req.query,
      body: req.body,
      user: (req as any).user?.id
    });
  } else {
    logger.warn('Client error', {
      statusCode,
      message,
      code,
      path: req.path,
      method: req.method,
      user: (req as any).user?.id
    });
  }
  
  // Send response
  res.status(statusCode).json({
    error: {
      message,
      code,
      details
    }
});
}
```

### 11.3 Structured Logging System

```typescript
// lib/logger.ts
import pino from 'pino';

// Define log levels
const levels = {
  trace: 10,
  debug: 20,
  info: 30,
  warn: 40,
  error: 50,
  fatal: 60
};

// Configure logger
const logger = pino({
  level: process.env.LOG_LEVEL || 'info',
  enabled: process.env.NODE_ENV !== 'test',
  formatters: {
    level: (label) => {
      return { level: label };
    }
  },
  timestamp: () => `,"time":"${new Date().toISOString()}"`,
  // Redact sensitive fields
  redact: {
    paths: [
      'password',
      'passwordHash',
      'token',
      'authorization',
      'Authorization',
      'cookie',
      'jwt'
    ],
    censor: '[REDACTED]'
  },
  transport: process.env.NODE_ENV !== 'production' 
    ? { target: 'pino-pretty' }
    : undefined,
  base: {
    env: process.env.NODE_ENV,
    serviceName: 'kodelab-api'
  }
});

// Add request context
export function createRequestLogger(req: any, res: any, next: Function) {
  // Generate unique request ID
  const requestId = req.headers['x-request-id'] || crypto.randomUUID();
  
  // Create a child logger with request context
  req.log = logger.child({
    requestId,
    method: req.method,
    url: req.url,
    ip: req.ip,
    userId: req.user?.id
  });
  
  // Add response header
  res.setHeader('X-Request-ID', requestId);
  
  next();
}

export { logger };
```

## 12. Testing Strategy

### 12.1 Unit Testing

Unit tests focus on testing individual functions and components in isolation:

```typescript
// Example unit test for User service
import { describe, it, expect, beforeEach, vi } from 'vitest';
import { UserService } from '../src/services/user.service';
import { prisma } from '../src/lib/prisma';

// Mock Prisma
vi.mock('../src/lib/prisma', () => ({
  prisma: {
    user: {
      findUnique: vi.fn(),
      findMany: vi.fn(),
      create: vi.fn(),
      update: vi.fn(),
      delete: vi.fn()
    }
  }
}));

describe('UserService', () => {
  let userService: UserService;
  
  beforeEach(() => {
    userService = new UserService();
    vi.clearAllMocks();
  });
  
  describe('getUserById', () => {
    it('should return a user when found', async () => {
      // Arrange
      const mockUser = { id: '123', name: 'Test User', email: 'test@example.com' };
      prisma.user.findUnique.mockResolvedValue(mockUser);
      
      // Act
      const result = await userService.getUserById('123');
      
      // Assert
      expect(result).toEqual(mockUser);
      expect(prisma.user.findUnique).toHaveBeenCalledWith({
        where: { id: '123' }
      });
    });
    
    it('should throw NotFoundError when user not found', async () => {
      // Arrange
      prisma.user.findUnique.mockResolvedValue(null);
      
      // Act & Assert
      await expect(userService.getUserById('123')).rejects.toThrow('User not found');
      expect(prisma.user.findUnique).toHaveBeenCalledWith({
        where: { id: '123' }
      });
    });
  });
});
```

### 12.2 Integration Testing

Integration tests verify that different modules work together correctly:

```typescript
// Example integration test for Challenge API
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import request from 'supertest';
import { app } from '../src/app';
import { setupTestDatabase, teardownTestDatabase, generateToken } from './helpers/test-utils';

describe('Challenge API', () => {
  let testDb;
  let adminToken;
  let userToken;
  
  beforeAll(async () => {
    // Set up test database
    testDb = await setupTestDatabase();
    
    // Generate test tokens
    adminToken = await generateToken('admin');
    userToken = await generateToken('user');
  });
  
  afterAll(async () => {
    await teardownTestDatabase(testDb);
  });
  
  describe('GET /api/challenges', () => {
    it('should return a list of public challenges', async () => {
      // Act
      const response = await request(app)
        .get('/api/challenges')
        .expect(200);
      
      // Assert
      expect(response.body.challenges).toBeInstanceOf(Array);
      expect(response.body.pagination).toHaveProperty('total');
    });
    
    it('should filter challenges by difficulty', async () => {
      // Act
      const response = await request(app)
        .get('/api/challenges?difficulty=BEGINNER')
        .expect(200);
      
      // Assert
      expect(response.body.challenges).toBeInstanceOf(Array);
      response.body.challenges.forEach(challenge => {
        expect(challenge.difficulty).toBe('BEGINNER');
      });
    });
  });
  
  describe('POST /api/challenges', () => {
    it('should create a new challenge when authenticated as instructor', async () => {
      // Arrange
      const newChallenge = {
        title: 'Test Challenge',
        description: 'A test challenge',
        difficulty: 'BEGINNER',
        category: 'algorithms',
        instructions: 'Implement the function',
        starterCode: 'function solution() {}',
        solutionCode: 'function solution() { return true; }',
        testCases: [
          {
            description: 'Test case 1',
            functionName: 'solution',
            input: '',
            expectedOutput: 'true',
            isPublic: true
          }
        ]
      };
      
      // Act
      const response = await request(app)
        .post('/api/challenges')
        .set('Authorization', `Bearer ${adminToken}`)
        .send(newChallenge)
        .expect(201);
      
      // Assert
      expect(response.body).toHaveProperty('id');
      expect(response.body.title).toBe(newChallenge.title);
    });
    
    it('should return 403 when user is not an instructor', async () => {
      // Act & Assert
      await request(app)
        .post('/api/challenges')
        .set('Authorization', `Bearer ${userToken}`)
        .send({ title: 'Test' })
        .expect(403);
    });
  });
});
```

### 12.3 End-to-End Testing

End-to-end tests verify the full user flow through the application:

```typescript
// Example E2E test using Playwright
import { test, expect } from '@playwright/test';

test.describe('Challenge Submission Flow', () => {
  test.beforeEach(async ({ page }) => {
    // Log in
    await page.goto('/login');
    await page.fill('input[name="email"]', 'test@example.com');
    await page.fill('input[name="password"]', 'password123');
    await page.click('button[type="submit"]');
    
    // Wait for dashboard to load
    await page.waitForURL('/dashboard');
  });
  
  test('user can submit a successful solution', async ({ page }) => {
    // Navigate to a challenge
    await page.goto('/challenges');
    await page.click('text="Beginner Challenges"');
    await page.click('text="Sum of Two Numbers"');
    
    // Verify challenge loaded
    await expect(page.locator('h1')).toContainText('Sum of Two Numbers');
    
    // Write a solution
    const editor = page.locator('.cm-content');
    await editor.click();
    await page.keyboard.press('Control+A');
    await page.keyboard.press('Delete');
    await page.keyboard.type(`
      function sumTwoNumbers(a, b) {
        return a + b;
      }
      
      module.exports = { sumTwoNumbers };
    `);
    
    // Submit solution
    await page.click('button:has-text("Submit")');
    
    // Verify test results
    await expect(page.locator('text="All Tests Passed!"')).toBeVisible({ timeout: 10000 });
    
    // Wait for feedback
    await expect(page.locator('text="AI Feedback"')).toBeVisible({ timeout: 30000 });
    
    // Check for feedback content
    await expect(page.locator('text="Code Strengths"')).toBeVisible();
  });
  
  test('user gets appropriate feedback for failing solution', async ({ page }) => {
    // Navigate to a challenge
    await page.goto('/challenges');
    await page.click('text="Beginner Challenges"');
    await page.click('text="Sum of Two Numbers"');
    
    // Write an incorrect solution
    const editor = page.locator('.cm-content');
    await editor.click();
    await page.keyboard.press('Control+A');
    await page.keyboard.press('Delete');
    await page.keyboard.type(`
      function sumTwoNumbers(a, b) {
        return a - b; // Incorrect implementation
      }
      
      module.exports = { sumTwoNumbers };
    `);
    
    // Submit solution
    await page.click('button:has-text("Submit")');
    
    // Verify test failures
    await expect(page.locator('text="Tests Failed"')).toBeVisible({ timeout: 10000 });
    await expect(page.locator('text="Expected: 5"')).toBeVisible();
    await expect(page.locator('text="Actual: -1"')).toBeVisible();
  });
});
```

### 12.4 Testing Pipeline

```yaml
# CI test pipeline in GitHub Actions
name: Test Pipeline

on:
  pull_request:
    branches: [ main, staging ]
  push:
    branches: [ main, staging ]

jobs:
  unit-tests:
    name: Unit Tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run unit tests
        run: npm run test:unit
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          directory: ./coverage
  
  integration-tests:
    name: Integration Tests
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: postgres
          POSTGRES_DB: test
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
      
      redis:
        image: redis:7
        ports:
          - 6379:6379
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Set up test database
        run: |
          npm run prisma:generate
          npm run prisma:migrate:test
      
      - name: Run integration tests
        run: npm run test:integration
        env:
          DATABASE_URL: postgresql://postgres:postgres@localhost:5432/test
          REDIS_URL: redis://localhost:6379
          JWT_SECRET: test-secret
  
  e2e-tests:
    name: End-to-End Tests
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Install Playwright
        run: npx playwright install --with-deps
      
      - name: Build frontend
        run: npm run build
      
      - name: Start test server
        run: npm run start:test &
        env:
          DATABASE_URL: ${{ secrets.TEST_DATABASE_URL }}
          REDIS_URL: ${{ secrets.TEST_REDIS_URL }}
          JWT_SECRET: test-secret
      
      - name: Wait for server
        run: npx wait-on http://localhost:3000
      
      - name: Run E2E tests
        run: npm run test:e2e
      
      - name: Upload test artifacts
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: playwright-report
          path: playwright-report/
```

## 13. DevOps and Deployment

### 13.1 CI/CD Pipeline

```yaml
# .github/workflows/ci-cd.yml
name: CI/CD Pipeline

on:
  push:
    branches: [ main, staging ]
  pull_request:
    branches: [ main, staging ]

jobs:
  validate:
    name: Validate & Test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Lint code
        run: npm run lint
      
      - name: Type check
        run: npm run type-check
      
      - name: Run unit tests
        run: npm run test:unit
      
      - name: Run integration tests
        run: npm run test:integration
      
      - name: Check for vulnerabilities
        run: npm audit --production
        
  security_scan:
    name: Security Scanning
    runs-on: ubuntu-latest
    needs: validate
    steps:
      - uses: actions/checkout@v3
      
      - name: Run OWASP ZAP scan
        uses: zaproxy/action-baseline@v0.9.0
        with:
          target: 'https://staging.kodelab.io'
      
      - name: Run dependency scanning
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          format: 'sarif'
          output: 'trivy-results.sarif'
      
      - name: Upload scan results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'
  
  build:
    name: Build & Push
    runs-on: ubuntu-latest
    needs: validate
    if: github.event_name == 'push' || github.event.pull_request.head.repo.full_name == github.repository
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      
      - name: Login to DigitalOcean Container Registry
        uses: docker/login-action@v2
        with:
          registry: registry.digitalocean.com
          username: ${{ secrets.DIGITALOCEAN_ACCESS_TOKEN }}
          password: ${{ secrets.DIGITALOCEAN_ACCESS_TOKEN }}
      
      - name: Extract branch name
        id: extract_branch
        run: echo "branch=${GITHUB_REF#refs/heads/}" >> $GITHUB_OUTPUT
      
      - name: Build and push frontend
        uses: docker/build-push-action@v4
        with:
          context: ./frontend
          push: true
          tags: |
            registry.digitalocean.com/kodelab/frontend:${{ steps.extract_branch.outputs.branch }}
            registry.digitalocean.com/kodelab/frontend:${{ github.sha }}
          cache-from: type=registry,ref=registry.digitalocean.com/kodelab/frontend:buildcache
          cache-to: type=registry,ref=registry.digitalocean.com/kodelab/frontend:buildcache,mode=max
      
      - name: Build and push backend
        uses: docker/build-push-action@v4
        with:
          context: ./backend
          push: true
          tags: |
            registry.digitalocean.com/kodelab/backend:${{ steps.extract_branch.outputs.branch }}
            registry.digitalocean.com/kodelab/backend:${{ github.sha }}
          cache-from: type=registry,ref=registry.digitalocean.com/kodelab/backend:buildcache
          cache-to: type=registry,ref=registry.digitalocean.com/kodelab/backend:buildcache,mode=max
  
  deploy:
    name: Deploy
    runs-on: ubuntu-latest
    needs: build
    if: github.event_name == 'push'
    steps:
      - name: Install doctl
        uses: digitalocean/action-doctl@v2
        with:
          token: ${{ secrets.DIGITALOCEAN_ACCESS_TOKEN }}
      
      - name: Extract branch name
        id: extract_branch
        run: echo "branch=${GITHUB_REF#refs/heads/}" >> $GITHUB_OUTPUT
      
      - name: Set environment name
        id: env_name
        run: |
          if [ "${{ steps.extract_branch.outputs.branch }}" == "main" ]; then
            echo "env_name=production" >> $GITHUB_OUTPUT
          else
            echo "env_name=${{ steps.extract_branch.outputs.branch }}" >> $GITHUB_OUTPUT
          fi
      
      - name: Update App Platform deployment
        run: |
          doctl apps update ${{ secrets.DO_APP_ID_PREFIX }}-${{ steps.env_name.outputs.env_name }} --spec ./deploy/${{ steps.env_name.outputs.env_name }}.yaml
      
      - name: Apply database migrations
        run: |
          doctl apps create-deployment ${{ secrets.DO_APP_ID_PREFIX }}-${{ steps.env_name.outputs.env_name }} --force
      
      - name: Create Sentry release
        uses: getsentry/action-release@v1
        env:
          SENTRY_AUTH_TOKEN: ${{ secrets.SENTRY_AUTH_TOKEN }}
          SENTRY_ORG: kodelab
          SENTRY_PROJECT: kodelab-platform
        with:
          environment: ${{ steps.env_name.outputs.env_name }}
          version: ${{ github.sha }}
```

### 13.2 Docker Compose Setup for Development

```yaml
# docker-compose.yml
version: '3.8'
services:
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.dev
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - NEXT_PUBLIC_API_URL=http://localhost:4000
    depends_on:
      - backend
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/api/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      
  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.dev
    ports:
      - "4000:4000"
    volumes:
      - ./backend:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://postgres:postgres@pgbouncer:6432/kodelab
      - REDIS_URL=redis://redis:6379
      - SESSION_SECRET=${SESSION_SECRET}
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - CORS_ORIGIN=http://localhost:3000
    depends_on:
      pgbouncer:
        condition: service_healthy
      redis:
        condition: service_healthy
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:4000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      
  db:
    image: postgres:16-alpine
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=kodelab
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 5
    restart: unless-stopped

  pgbouncer:
    image: edoburu/pgbouncer:1.18.0
    ports:
      - "6432:6432"
    environment:
      - DB_USER=postgres
      - DB_PASSWORD=postgres
      - DB_HOST=db
      - DB_NAME=kodelab
      - POOL_MODE=transaction
      - MAX_CLIENT_CONN=100
      - DEFAULT_POOL_SIZE=20
    depends_on:
      db:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "pg_isready", "-h", "localhost", "-p", "6432", "-U", "postgres"]
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped

  redis:
    image: redis:7.2-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    command: redis-server --appendonly yes
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 5s
      timeout: 5s
      retries: 5
    restart: unless-stopped

  mailhog:
    image: mailhog/mailhog
    ports:
      - "8025:8025" # Web UI
      - "1025:1025" # SMTP Server
    restart: unless-stopped

  storybook:
    build:
      context: ./frontend
      dockerfile: Dockerfile.storybook
    ports:
      - "6006:6006"
    volumes:
      - ./frontend:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
    restart: unless-stopped

  pgadmin:
    image: dpage/pgadmin4
    ports:
      - "8080:80"
    environment:
      - PGADMIN_DEFAULT_EMAIL=admin@example.com
      - PGADMIN_DEFAULT_PASSWORD=admin
    depends_on:
      - db
    restart: unless-stopped

volumes:
  postgres_data:
  redis_data:
```

### 13.3 Deployment Configuration

```yaml
# deploy/production.yaml
name: kodelab-production
region: nyc
services:
  - name: frontend
    github:
      branch: main
      deploy_on_push: true
      repo: kodelab/kodelab
    build_command: npm run build
    run_command: npm start
    http_port: 3000
    instance_count: 2
    instance_size_slug: basic-s
    routes:
      - path: /
    envs:
      - key: NODE_ENV
        value: production
      - key: NEXT_PUBLIC_API_URL
        value: https://api.kodelab.io
      - key: SENTRY_DSN
        value: ${sentry_dsn}
        type: secret
  
  - name: backend
    github:
      branch: main
      deploy_on_push: true
      repo: kodelab/kodelab
    build_command: npm run build
    run_command: npm start
    http_port: 4000
    instance_count: 2
    instance_size_slug: basic-s
    routes:
      - path: /api
    envs:
      - key: NODE_ENV
        value: production
      - key: DATABASE_URL
        value: ${db_url}
        type: secret
      - key: REDIS_URL
        value: ${redis_url}
        type: secret
      - key: JWT_SECRET
        value: ${jwt_secret}
        type: secret
      - key: OPENAI_API_KEY
        value: ${openai_api_key}
        type: secret
      - key: SENTRY_DSN
        value: ${sentry_dsn}
        type: secret
      - key: SPACES_KEY
        value: ${spaces_key}
        type: secret
      - key: SPACES_SECRET
        value: ${spaces_secret}
        type: secret

databases:
  - name: db
    engine: PG
    version: "16"
    cluster_name: kodelab-db
    production: true
    db_name: kodelab
    db_user: kodelab_user

redis:
  - name: redis
    production: true
```

## 14. Scalability and Performance

### 14.1 Database Scalability

1. **Connection Pooling**:
   - PgBouncer for efficient connection management
   - Connection limits based on instance size
   - Connection timeout policies

2. **Read/Write Separation**:
   - Potential for read replicas in Phase 2
   - Query routing based on operation type
   - Analytics queries directed to replicas

3. **Data Partitioning**:
   - Time-based partitioning for submission data
   - Sharding strategy for future scaling
   - Archive policy for old submissions

### 14.2 Application Scaling

1. **Horizontal Scaling**:
   - Stateless API design for load balancing
   - Session data in Redis for shared state
   - Multiple frontend instances

2. **Asynchronous Processing**:
   - Queue-based code execution
   - Background feedback generation
   - Scheduled tasks for analytics

3. **Caching Strategy**:
   - Multi-level caching approach
   - Redis for shared cache data
   - Response caching for public endpoints
   - Database query results caching

### 14.3 Performance Optimization Techniques

1. **Backend Optimizations**:
   - Efficient database queries
   - Batching for multiple operations
   - Pagination for large result sets
   - Timeout and retry mechanisms

2. **Frontend Optimizations**:
   - Code splitting for reduced bundle size
   - Tree shaking for dead code elimination
   - Lazy loading for non-critical components
   - Image optimization and responsive loading
   - Server-side rendering for critical pages

### 14.5 Operational Resilience

The system is designed with robust operational resilience to handle various failure scenarios and peak loads:

#### 14.5.1 Enhanced Monitoring

- **AI Feedback Pipeline Observability**: Detailed tracking of each stage in the feedback generation process
  - Real-time metrics on pipeline performance
  - Token usage tracking by challenge type and user segment
  - Latency measurements for each processing step
  - Error rate monitoring with automated alerting
  - Cost optimization tracking and anomaly detection

- **User Activity Patterns**:
  - Identification of peak usage periods
  - Correlation with academic calendars and assignment deadlines
  - Predictive modeling for resource allocation
  - Session analytics for UX optimization

#### 14.5.2 Load Testing Strategy

- **Academic-Calendar-Aware Testing**: Simulations based on typical semester patterns
  - Assignment deadline scenarios with 5-10x normal traffic
  - Beginning-of-semester onboarding surges
  - End-of-semester project submission peaks

- **Scenario-Based Testing**:
  - Large class simultaneous submissions
  - Concurrent feedback generation load
  - Database query performance under peak conditions
  - Cache efficiency during high-traffic periods

#### 14.5.3 Feedback Fallback Mechanisms

- **Multi-Tiered Degradation**:
  - Primary: Full AI-powered feedback (GPT-4/Claude)
  - Secondary: Pattern-based feedback with lightweight AI enhancement
  - Tertiary: Pure pattern matching with cached responses
  - Minimal: Automated test results with generic improvement suggestions

- **Feedback Queue Management**:
  - Dynamic prioritization based on user type and context
  - Transparent status communication to users
  - Graceful timeout handling with partial results delivery
  - Scheduled retry mechanisms with exponential backoff

- **Service Level Objectives**:
  - 99.5% availability for core execution platform
  - 99% availability for feedback generation
  - 95% of feedback delivered within 2 minutes
  - 99.9% of submissions evaluated with at least basic feedback

The system is designed with robust operational resilience to handle various failure scenarios and peak loads:

#### 14.5.1 Enhanced Monitoring

- **AI Feedback Pipeline Observability**: Detailed tracking of each stage in the feedback generation process
  - Real-time metrics on pipeline performance
  - Token usage tracking by challenge type and user segment
  - Latency measurements for each processing step
  - Error rate monitoring with automated alerting
  - Cost optimization tracking and anomaly detection

- **User Activity Patterns**:
  - Identification of peak usage periods
  - Correlation with academic calendars and assignment deadlines
  - Predictive modeling for resource allocation
  - Session analytics for UX optimization

#### 14.5.2 Load Testing Strategy

- **Academic-Calendar-Aware Testing**: Simulations based on typical semester patterns
  - Assignment deadline scenarios with 5-10x normal traffic
  - Beginning-of-semester onboarding surges
  - End-of-semester project submission peaks

- **Scenario-Based Testing**:
  - Large class simultaneous submissions
  - Concurrent feedback generation load
  - Database query performance under peak conditions
  - Cache efficiency during high-traffic periods

#### 14.5.3 Feedback Fallback Mechanisms

- **Multi-Tiered Degradation**:
  - Primary: Full AI-powered feedback (GPT-4/Claude)
  - Secondary: Pattern-based feedback with lightweight AI enhancement
  - Tertiary: Pure pattern matching with cached responses
  - Minimal: Automated test results with generic improvement suggestions

- **Feedback Queue Management**:
  - Dynamic prioritization based on user type and context
  - Transparent status communication to users
  - Graceful timeout handling with partial results delivery
  - Scheduled retry mechanisms with exponential backoff

- **Service Level Objectives**:
  - 99.5% availability for core execution platform
  - 99% availability for feedback generation
  - 95% of feedback delivered within 2 minutes
  - 99.9% of submissions evaluated with at least basic feedback

## 15. Academic Integration

### 15.1 LMS Integration (Phase 2)

1. **LTI 1.3 Implementation**:
   - Single sign-on from LMS platforms
   - Grade passback to LMS gradebooks
   - Deep linking to specific challenges
   - Resource selection for instructors

2. **Supported Platforms**:
   - Canvas
   - Blackboard
   - Moodle
   - Google Classroom

3. **Integration Features**:
   - Course roster synchronization
   - Assignment creation and management
   - Grade reporting automation
   - Content embedding in LMS

### 15.2 Instructor Tools

1. **Assignment Management**:
   - Challenge assignment to classes
   - Due date management
   - Custom instructions addition
   - Deadline extensions

2. **Student Progress Tracking**:
   - Class-level progress dashboards
   - Individual student performance metrics
   - Submission history review
   - Feedback effectiveness analysis

3. **Analytics for Instruction**:
   - Challenge difficulty analysis
   - Skill gap identification
   - Time-to-completion metrics
   - Comparative class performance

### 15.4 Learning Analytics

The platform provides comprehensive learning analytics aligned with CS curriculum frameworks:

#### 15.4.1 Educational Insights

- **Concept Mastery Tracking**: Automated assessment of student understanding across key CS concepts
  - Data structures proficiency
  - Algorithm implementation skills
  - Code organization and clarity
  - Testing and debugging practices
  - Performance optimization understanding

- **Curriculum Alignment Reporting**:
  - Mapping challenge completion to course learning objectives
  - Identification of concept gaps in student understanding
  - Course-level performance analytics
  - Longitudinal skill development tracking

- **Standards-Based Assessment**:
  - Alignment with ACM/IEEE Computer Science Curriculum standards
  - Industry certification readiness indicators
  - ABET accreditation criteria mapping
  - Competency-based achievement tracking

#### 15.4.2 Skills Taxonomy

The platform implements a detailed skills taxonomy that maps challenges to specific competencies:

The platform provides comprehensive learning analytics aligned with CS curriculum frameworks:

#### 15.4.1 Educational Insights

- **Concept Mastery Tracking**: Automated assessment of student understanding across key CS concepts
  - Data structures proficiency
  - Algorithm implementation skills
  - Code organization and clarity
  - Testing and debugging practices
  - Performance optimization understanding

- **Curriculum Alignment Reporting**:
  - Mapping challenge completion to course learning objectives
  - Identification of concept gaps in student understanding
  - Course-level performance analytics
  - Longitudinal skill development tracking

- **Standards-Based Assessment**:
  - Alignment with ACM/IEEE Computer Science Curriculum standards
  - Industry certification readiness indicators
  - ABET accreditation criteria mapping
  - Competency-based achievement tracking

  #### 15.4.2 Skills Taxonomy

  The platform implements a detailed skills taxonomy that maps challenges to specific competencies:

  - **Hierarchical Skill Structure**:
    - Primary domains (Algorithms, Data Structures, Web Development, etc.)
    - Subdomains with increasing specialization
    - Specific competencies at the leaf level
    - Cross-cutting concepts that span multiple domains

  - **Challenge-Skill Mapping**:
    - Each challenge maps to multiple skills with weighted relevance
    - Skills are assessed at different proficiency levels (awareness, application, mastery)
    - Prerequisite relationships between skills
    - Skill dependency graphs for learning path generation

  - **Industry Alignment**:
    - Skills mapped to industry job roles and requirements
    - Technical skills (language proficiency, algorithms, etc.)
    - Professional skills (code quality, documentation, testing)
    - Problem-solving approaches (decomposition, optimization, debugging)

  - **Assessment Framework**:
    - Objective measurement criteria for each skill
    - Automated evaluation through code analysis
    - Performance metrics tied to specific competencies
    - Confidence scoring for skill assessments

  ## 16. Code Style and Best Practice

  The KodeLab platform follows strict development standards to ensure code quality, maintainability, and consistency across the codebase.

  ### 16.1 TypeScript Standards

  ```typescript
// Example of TypeScript standards
// Use explicit types for function parameters and return values
function calculateScore(correctAnswers: number, totalQuestions: number): number {
  return (correctAnswers / totalQuestions) * 100;
}

// Use interfaces for structured data
interface User {
  id: string;
  name: string;
  email: string;
  role: UserRole;
  createdAt: Date;
}

// Use enums for predefined values
enum UserRole {
  Student = 'STUDENT',
  Instructor = 'INSTRUCTOR',
  Admin = 'ADMIN'
}

// Use type guards for runtime type checking
function isAdmin(user: User): user is User & { role: UserRole.Admin } {
  return user.role === UserRole.Admin;
}

// Use generics for reusable components
function getFirst<T>(items: T[]): T | undefined {
  return items.length > 0 ? items[0] : undefined;
}

// Use readonly modifier for immutable properties
interface Config {
  readonly apiUrl: string;
  readonly maxRetries: number;
}
```

### 16.2 React Component Standards

```tsx
// Example of React component standards
// Use functional components with explicit types
interface ButtonProps {
  onClick?: () => void;
  disabled?: boolean;
  variant?: 'primary' | 'secondary' | 'danger';
  size?: 'small' | 'medium' | 'large';
  className?: string;
  children: React.ReactNode;
}

// Use destructuring for props
export function Button({
  onClick,
  disabled = false,
  variant = 'primary',
  size = 'medium',
  className = '',
  children
}: ButtonProps) {
  // Use classname composition
  const baseClass = 'btn';
  const variantClass = `btn-${variant}`;
  const sizeClass = `btn-${size}`;
  const buttonClass = `${baseClass} ${variantClass} ${sizeClass} ${className}`;
  
  // Use event handlers with proper types
  const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => {
    if (onClick) {
      onClick();
    }
  };
  
  // Return single element with logical props
  return (
    <button
      className={buttonClass}
      onClick={handleClick}
      disabled={disabled}
      type="button"
    >
      {children}
    </button>
  );
}

// Use custom hooks for reusable logic
function useLocalStorage<T>(key: string, initialValue: T): [T, (value: T) => void] {
  const [storedValue, setStoredValue] = useState<T>(() => {
    if (typeof window === 'undefined') {
      return initialValue;
    }
    
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.error(error);
      return initialValue;
    }
  });
  
  const setValue = (value: T) => {
    try {
      setStoredValue(value);
      if (typeof window !== 'undefined') {
        window.localStorage.setItem(key, JSON.stringify(value));
      }
    } catch (error) {
      console.error(error);
    }
  };
  
  return [storedValue, setValue];
}
```

### 16.3 API Endpoint Standards

```typescript
// Example of API endpoint standards
// Use consistent response structure
interface ApiResponse<T> {
  data?: T;
  error?: {
    message: string;
    code: string;
    details?: any;
  };
  pagination?: {
    page: number;
    limit: number;
    total: number;
    pages: number;
  };
}

// Use controller-service pattern
export class ChallengeController {
  private challengeService = new ChallengeService();
  
  // GET /api/challenges
  async getChallenges(req: Request, res: Response, next: NextFunction) {
    try {
      // Extract and validate query parameters
      const filters = ChallengeFilterSchema.parse(req.query);
      
      // Call service method
      const result = await this.challengeService.getChallenges(filters);
      
      // Return consistent response
      return res.status(200).json({
        data: result.challenges,
        pagination: result.pagination
      });
    } catch (error) {
      next(error);
    }
  }
  
  // GET /api/challenges/:id
  async getChallenge(req: Request, res: Response, next: NextFunction) {
    try {
      // Extract and validate path parameters
      const { id } = req.params;
      
      // Get user from request (added by auth middleware)
      const userId = (req as AuthRequest).user?.id;
      
      // Call service method
      const challenge = await this.challengeService.getChallenge(id, userId);
      
      // Return consistent response
      return res.status(200).json({
        data: challenge
      });
    } catch (error) {
      next(error);
    }
  }
}
```

## 17. Implementation Roadmap

### 17.1 Phase 1: Core Platform (8-10 weeks)

1. **Week 1-2: Project Setup and Authentication**
   - Repository and project structure setup
   - Database schema implementation
   - Authentication system (email/password, OAuth)
   - User management basics
   - Development environment with Docker Compose

2. **Week 3-4: Challenge Engine**
   - Challenge data models
   - Challenge creation interface
   - Code editor integration
   - Test case management
   - Basic challenge library (10-15 challenges)

3. **Week 5-6: Submission System**
   - Code execution environment
   - Submission processing system
   - Test result visualization
   - Progress tracking
   - Security measures for code execution

4. **Week 7-8: AI Feedback System**
   - AI integration with OpenAI/Claude
   - Feedback caching and optimization
   - Pattern-based feedback system
   - Feedback visualization
   - Cost control mechanisms

5. **Week 9-10: User Experience and Dashboard**
   - Student dashboard
   - Progress visualization
   - Challenge discovery and filtering
   - User profile management
   - Basic analytics implementation

### 17.2 Phase 2: Educational Integration (6-8 weeks)

1. **Week 1-2: LMS Integration**
   - LTI 1.3 provider implementation
   - Single sign-on with LMS platforms
   - Grade passback functionality
   - Deep linking capabilities

2. **Week 3-4: Course Management**
   - Course creation and management
   - Student enrollment
   - Assignment management
   - Deadline and due date handling

3. **Week 5-6: Enhanced Analytics**
   - Instructor dashboards
   - Student performance tracking
   - Challenge effectiveness analysis
   - Learning pattern visualization

4. **Week 7-8: Community Features**
   - Discussion threads for challenges
   - Solution sharing (post-completion)
   - Peer feedback mechanisms
   - Achievement and badge system

### 17.3 Phase 3: Scale and Enterprise (8-12 weeks)

1. **Week 1-3: Infrastructure Enhancement**
   - Kubernetes migration
   - Multi-region deployment
   - Enhanced monitoring
   - Disaster recovery planning

2. **Week 4-6: Enterprise Features**
   - Team management
   - Organization administration
   - Custom branding
   - Single sign-on for enterprises

3. **Week 7-9: Advanced Learning Tools**
   - Skill trees
   - Learning path customization
   - Project-based assessments
   - Interview preparation tracks

4. **Week 10-12: Data Insights**
   - Advanced analytics dashboard
   - Predictive modeling
   - Recommendation engine
   - Skills gap analysis

## 18. Technical Risks and Mitigations

### 18.1 Security Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| Insecure code execution | High | Isolated Docker containers, resource limits, network isolation |
| Authentication bypass | High | Multi-layer authentication, token validation, RBAC |
| Data exposure | Medium | Encryption at rest and in transit, access controls, audit logs |
| Dependency vulnerabilities | Medium | Regular scanning, automated updates, dependency pinning |
| Cross-site scripting (XSS) | Medium | Content Security Policy, input sanitization, output encoding |
| SQL injection | Medium | Parameterized queries via Prisma, input validation |
| CSRF attacks | Medium | CSRF tokens, same-site cookies, proper headers |

### 18.2 Scalability Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| Database performance | High | Connection pooling, query optimization, indexing strategy |
| AI costs | High | Multi-tiered approach, caching, pattern matching, quotas |
| Traffic spikes | Medium | Auto-scaling, rate limiting, queue-based processing |
| Storage growth | Medium | Data retention policies, archiving, efficient storage |
| API performance bottlenecks | Medium | Caching, pagination, efficient queries |
| Long-running operations | Medium | Asynchronous processing, background jobs, timeouts |

### 18.3 Technical Debt Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| Code maintainability | Medium | Clear architecture, code standards, regular refactoring |
| Documentation gaps | Medium | Inline documentation, API docs, architecture diagrams |
| Testing coverage | Medium | Comprehensive test suite, CI enforcement |
| Dependency management | Medium | Regular updates, compatibility testing |
| Feature creep | Medium | Clear requirements, MVP approach, prioritization |

This comprehensive system architecture design provides a detailed blueprint for implementing the KodeLab platform. With a phased approach and attention to security, scalability, and educational value, the platform will bridge the gap between academic coding and real-world job requirements through hands-on challenges and personalized AI feedback.

## 19. Platform Enhancement Recommendations

### 19.1 User Experience Focus

#### 19.1.1 Accessibility Standards

- Implement WCAG 2.1 AA compliance across all interfaces
- Provide keyboard navigation for all platform functions
- Ensure screen reader compatibility through proper ARIA attributes
- Support high contrast mode and text scaling
- Implement focus management for dynamic content
- Conduct regular accessibility audits with automated and manual testing

#### 19.1.2 Student Onboarding

- Create a scaffolded onboarding experience with progressive disclosure
- Develop "quick win" introductory challenges to build confidence
- Implement interactive tutorials for platform features
- Provide contextual help based on user behavior patterns
- Create personalized onboarding paths based on experience level
- Embed concept refreshers at point of need

#### 19.1.3 Mobile Experience

- Implement responsive design for all user interfaces
- Optimize code review experience for mobile devices
- Create mobile-friendly feedback visualization
- Support offline review of feedback and challenge instructions
- Implement touch-friendly code editor with appropriate gestures
- Ensure readable test results on smaller screens

### 19.2 Market Differentiation

#### 19.2.1 Employer Partnerships

- Develop an employer portal for challenge contribution
- Create a verification system for industry-relevant challenges
- Implement branded challenge collections from partner companies
- Provide analytics to employers on skill gaps and talent pipeline
- Facilitate optional talent discovery for high-performing students
- Create industry advisory board for platform direction

#### 19.2.2 Portfolio Generation

- Automatically compile completed challenges into a portfolio
- Generate verifiable skill credentials backed by evidence
- Create shareable project showcases with challenge context
- Support export to GitHub, LinkedIn, and personal websites
- Implement digital badges for skills and achievements
- Provide portfolio analytics for students to identify gaps

#### 19.2.3 Academic Research Opportunities

- Design anonymized data export for educational research
- Implement configurable experimentation framework for pedagogy research
- Create research partnership program with educational institutions
- Support A/B testing of different feedback approaches
- Collect rich metadata for learning pattern analysis
- Provide research API for approved academic partners
- Facilitate publication of insights from platform data

## 20. Strategic Recommendations

Based on a thorough review of the current system architecture design, the following strategic recommendations have been incorporated to strengthen the KodeLab platform in key areas:

### 20.1 AI Feedback Optimization

#### 20.1.1 Strategic Recommendations

- **Feedback Quality Metrics**: Implement specific metrics to measure AI feedback quality, beyond just cost optimization. This includes user ratings for feedback relevance, actionability scores, and implementation tracking.
- **Human Review Loop**: Create a mechanism for instructors to periodically review AI-generated feedback to ensure educational quality and identify improvement patterns.
- **Expanded Pattern Library**: Build a more comprehensive library of code patterns by language and challenge type to reduce dependence on expensive AI calls.

#### 20.1.2 Implementation Plan

**Feedback Quality Metrics** (Weeks 1-2):
- Implement student feedback rating system
- Create feedback effectiveness dashboard
- Develop feedback implementation tracking
- Build metrics collection and visualization

**Human Review Loop** (Weeks 3-4):
- Create instructor feedback review interface
- Implement feedback sampling algorithm 
- Develop annotation system for feedback
- Build feedback quality trend analytics

**Expanded Pattern Library** (Weeks 1-4):
- Enhance pattern detection algorithms
- Implement pattern categorization system
- Create pattern effectiveness tracking
- Build pattern management interface

### 20.2 Educational Enhancement

#### 20.2.1 Strategic Recommendations

- **Learning Analytics**: Expand the analytics module to include educational insights aligned with CS curriculum frameworks.
- **Skills Taxonomy**: Develop a detailed skills taxonomy that maps challenges to specific developer competencies valued by employers.
- **Guided Learning Paths**: Prioritize the implementation of structured learning paths that create progressive skill development journeys.

#### 20.2.2 Implementation Plan

**Learning Analytics** (Weeks 5-6):
- Map challenges to CS curriculum frameworks (ACM/IEEE)
- Implement learning pattern analysis for student progress
- Create mastery metrics to track skill development
- Build curriculum alignment visualization

**Skills Taxonomy** (Weeks 7-8):
- Develop comprehensive skill taxonomy model
- Implement Bayesian skill assessment algorithm
- Create visualization of skill development over time
- Build industry alignment mapping

**Guided Learning Paths** (Weeks 9-10):
- Design prerequisite relationship model between challenges
- Implement personalized learning path generator
- Create dynamic path adjustment based on performance
- Build milestone and achievement system

### 20.3 User Experience Focus

#### 20.3.1 Strategic Recommendations

- **Accessibility Standards**: Ensure WCAG 2.1 AA compliance from the beginning, particularly important for educational institutions.
- **Student Onboarding**: Create a more scaffolded onboarding experience with "quick win" challenges to build confidence.
- **Mobile Experience**: Consider mobile-responsive design earlier in development for students who may review feedback on mobile devices.

#### 20.3.2 Implementation Plan

**Accessibility Standards** (Weeks 9-10):
- Audit and update UI components for WCAG 2.1 AA compliance
- Implement screen reader announcements for key interactions
- Create accessibility testing workflow
- Build high-contrast mode and keyboard navigation

**Student Onboarding** (Weeks 11-12):
- Design step-by-step onboarding flow for new users
- Create skill assessment during onboarding
- Implement "quick win" first challenges based on skill level
- Build progress celebration and reinforcement system

**Mobile Experience** (Weeks 13-14):
- Update responsive design for critical user flows
- Optimize code editor for mobile viewing
- Create mobile-specific feedback view
- Implement offline review capabilities for feedback

### 20.4 Operational Resilience

#### 20.4.1 Strategic Recommendations

- **Enhanced Monitoring**: Implement more comprehensive observability with detailed tracking of AI feedback pipeline performance and costs.
- **Load Testing Strategy**: Develop specific load testing scenarios focused on peak usage periods (assignment deadlines).
- **Feedback Fallback Mechanisms**: Strengthen the fallback mechanisms when AI services are unavailable or over quota.

#### 20.4.2 Implementation Plan

**Enhanced Monitoring** (Weeks 13-14):
- Implement OpenTelemetry metrics for AI operations
- Create dashboards for token usage and latency
- Set up alerting for AI service degradation
- Build predictive analytics for usage patterns

**Load Testing Strategy** (Weeks 15-16):
- Design peak load scenarios based on academic calendars
- Implement load testing suite with realistic usage patterns
- Create capacity planning framework
- Build automated performance regression testing

**Feedback Fallback Mechanisms** (Weeks 15-16):
- Implement tiered fallback strategy for AI services
- Create pattern-based feedback generator
- Develop rule-based feedback for emergency fallbacks
- Build transparent communication system for service status

### 20.5 Market Differentiation

#### 20.5.1 Strategic Recommendations

- **Employer Partnerships**: Consider adding a component where employers can contribute real-world challenges from their work.
- **Portfolio Generation**: Enable students to build a verifiable skills portfolio from their completed challenges.
- **Academic Research Opportunities**: Design the platform to facilitate research on programming education and skill development.

#### 20.5.2 Implementation Plan

**Employer Partnerships** (Weeks 17-18):
- Create employer portal for challenge contribution
- Implement employer badge/certification system
- Design employer analytics dashboard
- Build challenge validation workflow

**Portfolio Generation** (Weeks 19-20):
- Create exportable skills portfolio
- Implement verification system for completed challenges
- Design visual representation of skill development
- Build integration with professional platforms (LinkedIn, GitHub)

**Academic Research Capabilities** (Weeks 21-22):
- Implement anonymized data export for researchers
- Create research partner API
- Design experiments framework for educational research
- Build consent management system for research participation

### 20.6 Implementation Sequence

The recommendations will be implemented in a phased approach over approximately 22 weeks:

1. **Phase 1: AI Feedback Optimization** (Weeks 1-4)
2. **Phase 2: Educational Enhancement** (Weeks 5-10)
3. **Phase 3: User Experience Focus** (Weeks 9-14, overlapping with Phase 2)
4. **Phase 4: Operational Resilience** (Weeks 13-16, overlapping with Phase 3)
5. **Phase 5: Market Differentiation** (Weeks 17-22)
This sequencing prioritizes improvements to the core AI feedback functionality while gradually building educational value and operational resilience, before focusing on market differentiation features.

## 21. Implementation Plan

### 21.1 Feedback Optimization

**Feedback Quality Metrics** (Weeks 1-2):
- Add feedback rating UI component for students to rate AI-generated feedback
- Extend AIFeedback model with relevance and actionability scores
- Implement analytics dashboard for feedback quality metrics

**Human Review Loop** (Weeks 3-4):
- Create instructor feedback review workflow
- Implement FeedbackReview model to track instructor assessment
- Add sampling mechanism to identify feedback for review

**Expanded Pattern Library** (Ongoing):
- Create repository of common code patterns per language
- Implement pattern matching service as fallback for AI
- Continuously expand pattern library based on AI model insights

### 21.2 Educational Enhancement

#### 21.2.1 Strategic Recommendations

- **Learning Analytics**: Expand the analytics module to include educational insights aligned with CS curriculum frameworks.
- **Skills Taxonomy**: Develop a detailed skills taxonomy that maps challenges to specific developer competencies valued by employers.
- **Guided Learning Paths**: Prioritize the implementation of structured learning paths that create progressive skill development journeys.

#### 21.2.2 Implementation Plan

**Learning Analytics** (Weeks 5-6):
- Map challenges to CS curriculum frameworks (ACM/IEEE)
- Implement learning pattern analysis for student progress
- Create mastery metrics to track skill development
- Build curriculum alignment visualization

**Skills Taxonomy** (Weeks 7-8):
- Develop comprehensive skill taxonomy model
- Implement Bayesian skill assessment algorithm
- Create visualization of skill development over time
- Build industry alignment mapping

**Guided Learning Paths** (Weeks 9-10):
- Design prerequisite relationship model between challenges
- Implement personalized learning path generator
- Create dynamic path adjustment based on performance
- Build milestone and achievement system

### 21.3 User Experience Focus

#### 21.3.1 Strategic Recommendations

- **Accessibility Standards**: Ensure WCAG 2.1 AA compliance from the beginning, particularly important for educational institutions.
- **Student Onboarding**: Create a more scaffolded onboarding experience with "quick win" challenges to build confidence.
- **Mobile Experience**: Consider mobile-responsive design earlier in development for students who may review feedback on mobile devices.

#### 21.3.2 Implementation Plan

**Accessibility Standards** (Weeks 9-10):
**Accessibility Standards** (Weeks 9-10):
- Audit and update UI components for WCAG 2.1 AA compliance
- Implement screen reader announcements for key interactions
- Create accessibility testing workflow
- Build high-contrast mode and keyboard navigation
**Student Onboarding** (Weeks 11-12):
- Design step-by-step onboarding flow for new users
- Create skill assessment during onboarding
- Implement "quick win" first challenges based on skill level

**Mobile Experience** (Weeks 13-14):
- Update responsive design for critical user flows
- Optimize code editor for mobile viewing
- Create mobile-specific feedback view

### 21.4 Operational Resilience

#### 21.4.1 Strategic Recommendations

- **Enhanced Monitoring**: Implement more comprehensive observability with detailed tracking of AI feedback pipeline performance and costs.
- **Load Testing Strategy**: Develop specific load testing scenarios focused on peak usage periods (assignment deadlines).
- **Feedback Fallback Mechanisms**: Strengthen the fallback mechanisms when AI services are unavailable or over quota.

#### 21.4.2 Implementation Plan

**Enhanced Monitoring** (Weeks 13-14):
- Implement OpenTelemetry metrics for AI operations
- Create dashboards for token usage and latency
- Set up alerting for AI service degradation

**Load Testing Strategy** (Weeks 15-16):
- Design peak load scenarios based on academic calendars
- Implement load testing suite with realistic usage patterns
- Create capacity planning framework

**Feedback Fallback Mechanisms** (Weeks 15-16):
- Implement tiered fallback strategy for AI services
- Create pattern-based feedback generator
- Develop rule-based feedback for emergency fallbacks

### 21.5 Market Differentiation

#### 21.5.1 Strategic Recommendations

- **Employer Partnerships**: Consider adding a component where employers can contribute real-world challenges from their work.
- **Portfolio Generation**: Enable students to build a verifiable skills portfolio from their completed challenges.
- **Academic Research Opportunities**: Design the platform to facilitate research on programming education and skill development.

#### 21.5.2 Implementation Plan

**Employer Partnerships** (Weeks 17-18):
- Create employer portal for challenge contribution
- Implement employer badge/certification system
- Design employer analytics dashboard
- Build challenge validation workflow

**Portfolio Generation** (Weeks 19-20):
- Create exportable skills portfolio
- Implement verification system for completed challenges
- Design visual representation of skill development
- Build integration with professional platforms (LinkedIn, GitHub)

**Academic Research Capabilities** (Weeks 21-22):
- Implement anonymized data export for researchers
- Create research partner API
- Design experiments framework for educational research
- Build consent management system for research participation

### 21.6 Implementation Sequence

The recommendations will be implemented in a phased approach over approximately 22 weeks:

1. **Phase 1: AI Feedback Optimization** (Weeks 1-4)
2. **Phase 2: Educational Enhancement** (Weeks 5-10)
3. **Phase 3: User Experience Focus** (Weeks 9-14, overlapping with Phase 2)
4. **Phase 4: Operational Resilience** (Weeks 13-16, overlapping with Phase 3)
5. **Phase 5: Market Differentiation** (Weeks 17-22)

This sequencing prioritizes improvements to the core AI feedback functionality while gradually building educational value and operational resilience, before focusing on market differentiation features.
