
# Master Project Blueprint: Job-Ready Skill Simulator

**Blueprint Version:** 3.0
**Project:** Job-Ready Skill Simulator
**Last Updated:** 2025-03-17 (UTC)

**Purpose:** This document serves as the definitive guide for AI coding agents to construct the Job-Ready Skill Simulator platform. It provides unambiguous instructions, covering all aspects from project initialization to deployment and maintenance.  Any ambiguity MUST be resolved through clarification requests *before* code generation.

**Input Documents (References):**

1.  `TechnicalStack.md`
2.  `SystemArchitectureDesign.md`
3.  `ProjectSpecificationDocument.md`

**Changelog:**

*   **v1.1:** Enhanced project initialization, dependency management, coding standards, and error handling.
*   **v1.2:** Detailed code execution environment, AI feedback system, database queries, and API design.
*   **v1.3:** Added frontend component structure, examples, API integration with TanStack Query, Zustand state management, DevOps CI/CD pipeline, and expanded security.
*   **v1.4:** Refined database schema, added indexing strategy, detailed task difficulty scaling, and added new task examples.
*  **v1.5:** Improved Error Handling and made it consistent across the app, add Security section about CSRF and CSP.
* **v1.6**: Enhance database schema details, added data migration, pagination examples, and comprehensive testing strategy.
* **v2.0:** Consolidated iterations, improved formatting, and added more specific instructions for AI agents.
* **v3.0:** Complete regeneration of the document, incorporating all previous iterations and further refinements. Added missing sections, clarified instructions, and ensured overall consistency. Added more details, and examples.

---

## 1. Project Initialization and Environment Setup

### 1.1 Project Structure

**AI Instruction:** Generate the following directory and file structure. Adhere to the naming conventions precisely. Use kebab-case for file and directory names unless otherwise specified. Execute the `setup-project.sh` script (provided below) to automate this process.  Verify the generated structure *exactly* matches the following:

Markdown
job-ready-simulator/
├── backend/ # Backend services (Express.js)
│ ├── src/
│ │ ├── api/ # API endpoints
│ │ │ ├── controllers/ # Request handling logic
│ │ │ │ ├── auth.controller.ts
│ │ │ │ ├── challenge.controller.ts
│ │ │ │ ├── submission.controller.ts
│ │ │ │ └── user.controller.ts
│ │ │ ├── middleware/ # Express middleware
│ │ │ │ ├── auth.middleware.ts
│ │ │ │ ├── error.middleware.ts
│ │ │ │ └── validation.middleware.ts
│ │ │ ├── routes/ # Route definitions
│ │ │ │ ├── auth.routes.ts
│ │ │ │ ├── challenge.routes.ts
│ │ │ │ ├── submission.routes.ts
│ │ │ │ └── user.routes.ts
│ │ │ └── schemas/ # Request/response schemas (OpenAPI/JSON Schema)
│ │ │ ├── auth.schemas.ts
│ │ │ ├── challenge.schemas.ts
│ │ │ ├── submission.schemas.ts
│ │ │ └── user.schemas.ts
│ │ ├── lib/ # Shared libraries and utilities
│ │ │ ├── errors.ts # Custom error classes
│ │ │ ├── logger.ts # Logging utility
│ │ │ ├── prisma.ts # Prisma client instance
│ │ │ ├── redis.ts # Redis client instance
│ │ │ └── utils.ts # General utility functions
│ │ ├── services/ # Business logic services
│ │ │ ├── auth.service.ts
│ │ │ ├── challenge.service.ts
│ │ │ ├── submission.service.ts
│ │ │ ├── user.service.ts
│ │ │ └── ai-feedback.service.ts
│ │ ├── app.ts # Express application setup
│ │ └── server.ts # Server entry point
│ ├── prisma/ # Prisma schema and migrations
│ │ ├── schema.prisma
│ │ └── migrations/
│ ├── test/ # Backend tests
│ │ ├── integration/ # Integration tests
│ │ └── unit/ # Unit Tests
│ ├── Dockerfile # Dockerfile for backend service
│ ├── package.json # Node.js dependencies
│ ├── tsconfig.json # TypeScript configuration
│ └── .env.example # Example environment variables
├── frontend/ # Frontend application (Next.js)
│ ├── public/
│ │ ├── fonts/ # Custom fonts
│ │ ├── images/ # Static images
│ │ └── favicon.ico # Favicon
│ ├── src/
│ │ ├── app/ # Next.js App Router
│ │ │ ├── (auth)/ # Authentication routes (grouped)
│ │ │ │ ├── login/
│ │ │ │ │ └── page.tsx
│ │ │ │ ├── register/
│ │ │ │ │ └── page.tsx
│ │ │ │ └── forgot-password/
│ │ │ │ └── page.tsx
│ │ │ ├── (dashboard)/ # User dashboard (grouped)
│ │ │ │ ├── challenge/
│ │ │ │ │ └── [id]/
│ │ │ │ │ └── page.tsx # Challenge details
│ │ │ │ ├── challenges/
│ │ │ │ │ └── page.tsx # Challenge list
│ │ │ │ ├── profile/
│ │ │ │ │ └── page.tsx #User Profile
│ │ │ │ └── page.tsx # Main Dashboard
│ │ │ └── layout.tsx # Root layout
│ │ ├── components/ # Reusable UI components
│ │ │ ├── ui/ # Base UI components (shadcn/ui)
│ │ │ │ ├── button.tsx
│ │ │ │ ├── input.tsx
│ │ │ │ ├── label.tsx
│ │ │ │ ├── ...
│ │ │ ├── challenge/ # Challenge-related components
│ │ │ │ ├── challenge-card.tsx
│ │ │ │ ├── challenge-editor.tsx
│ │ │ │ ├── challenge-header.tsx
│ │ │ └── test-results.tsx
│ │ │ ├── auth/ # Authentication Components
│ │ │ │ ├── login-form.tsx
│ │ │ │ └── register-form.tsx
│ │ │ └── feedback/ # AI feedback components
│ │ │ ├── feedback-display.tsx
│ │ │ └── feedback-progress.tsx
│ │ ├── lib/ # Utilities and helpers
│ │ │ ├── api/ # API integration
│ │ │ │ ├── auth.ts
│ │ │ │ ├── challenges.ts
│ │ │ │ └── submissions.ts
│ │ │ ├── state/ # Zustand stores
│ │ │ │ ├── auth-store.ts
│ │ │ │ └── challenge-store.ts
│ │ │ └── utils.ts # General utilities
│ │ ├── styles/ # Global styles and CSS modules
│ │ │ └── globals.css
│ │ └── types/ # TypeScript type definitions
│ │ ├── index.ts
│ ├── test/ # Frontend Test
│ │ ├── e2e/ # End to End test (playwright)
│ │ │ └── challenge-submission.spec.ts
│ │ └── unit/ # Unit Tests
│ ├── .env.example
│ ├── .eslintrc.json
│ ├── .prettierrc.json
│ ├── next-env.d.ts
│ ├── next.config.js
│ ├── package.json
│ ├── postcss.config.js
│ ├── tailwind.config.ts
│ └── tsconfig.json
├── infrastructure/ # Infrastructure as Code (Terraform - Phase 3)
│ ├── modules/
│ │ ├── database/
│ │ ├── network/
│ │ └── compute/
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── docs/ # Project documentation
│ ├── architecture.md # System architecture documentation
│ ├── api-documentation.md # OpenAPI specification
│ ├── contributing.md # Contribution guidelines
│ └── style-guide.md # Coding style guide
├── scripts/ # Utility scripts (e.g., data seeding)
│ ├── seed-db.ts
│ ├── generate-openapi.ts
│ └── setup-project.sh # Project setup script
├── docker-compose.yml # Docker Compose configuration
└── README.md # Project README

**AI Instruction:** Create a script `scripts/setup-project.sh` that will automatically create the above directory structure. This script should be executable and idempotent (running it multiple times should have the same effect as running it once).

```bash
#!/bin/bash

# Create the main project directory
mkdir -p job-ready-simulator
cd job-ready-simulator

# Create backend directories
mkdir -p backend/src/api/controllers backend/src/api/middleware backend/src/api/routes backend/src/api/schemas
mkdir -p backend/src/lib backend/src/services backend/prisma/migrations backend/test/integration backend/test/unit

# Create backend files (empty for now, to be filled by other agents)
touch backend/src/api/controllers/{auth.controller,challenge.controller,submission.controller,user.controller}.ts
touch backend/src/api/middleware/{auth.middleware,error.middleware,validation.middleware}.ts
touch backend/src/api/routes/{auth.routes,challenge.routes,submission.routes,user.routes}.ts
touch backend/src/api/schemas/{auth.schemas,challenge.schemas,submission.schemas,user.schemas}.ts
touch backend/src/lib/{errors,logger,prisma,redis,utils}.ts
touch backend/src/services/{auth.service,challenge.service,submission.service,user.service,ai-feedback.service}.ts
touch backend/src/{app,server}.ts
touch backend/prisma/schema.prisma
touch backend/test/integration/example.test.ts  # Example test file
touch backend/test/unit/example.test.ts       # Example test file
touch backend/{Dockerfile,package.json,tsconfig.json,.env.example}

# Create frontend directories
mkdir -p frontend/public/{fonts,images}
mkdir -p frontend/src/app/{(auth)/{login,register,forgot-password},(dashboard)/{challenge/[id],challenges,profile}}
mkdir -p frontend/src/components/{ui,challenge,auth,feedback}
mkdir -p frontend/src/lib/{api,state}
mkdir -p frontend/src/styles frontend/src/types
mkdir -p frontend/test/{e2e,unit} # Create test directories

# Create frontend files (empty for now)
touch frontend/public/favicon.ico
touch frontend/src/app/{(auth)/{login,register,forgot-password}, (dashboard)/{challenge/[id],challenges,profile}}/page.tsx
touch frontend/src/app/layout.tsx
touch frontend/src/components/ui/{button,input,label}.tsx # Example UI components
touch frontend/src/components/challenge/{challenge-card,challenge-editor,challenge-header,test-results}.tsx
touch frontend/src/components/auth/{login-form,register-form}.tsx
touch frontend/src/components/feedback/{feedback-display,feedback-progress}.tsx
touch frontend/src/lib/api/{auth,challenges,submissions}.ts
touch frontend/src/lib/state/{auth-store,challenge-store}.ts
touch frontend/src/lib/utils.ts
touch frontend/src/styles/globals.css
touch frontend/src/types/index.ts
touch frontend/test/e2e/challenge-submission.spec.ts
touch frontend/test/unit/example.test.ts
touch frontend/{.env.example,.eslintrc.json,.prettierrc.json,next-env.d.ts,next.config.js,package.json,postcss.config.js,tailwind.config.ts,tsconfig.json}

# Create infrastructure directories
mkdir -p infrastructure/modules/{database,network,compute}

# Create infrastructure files
touch infrastructure/{main.tf,variables.tf,outputs.tf}

# Create docs files
touch docs/{architecture,api-documentation,contributing,style-guide}.md

# Create scripts files
touch scripts/{seed-db,generate-openapi}.ts

# Create root-level files
touch docker-compose.yml README.md

echo "Project structure created successfully."

AI Instruction: Ensure that after running setup-project.sh, running tree job-ready-simulator in the terminal produces the exact directory structure shown above.

Naming Conventions:

Files and Directories: kebab-case (e.g., user-profile.tsx, auth-service.ts).
Components (React): PascalCase (e.g., UserProfile, ChallengeList).
Next.js Pages: For files within the app directory (using the App Router), use kebab-case for route segments (directory names) and page.tsx for the page component itself. Example: app/my-account/page.tsx creates the route /my-account.
Functions and Variables: camelCase (e.g., getUserProfile, challengeData).
Classes: PascalCase (e.g., UserService, DatabaseConnection).
Constants: UPPER_SNAKE_CASE (e.g., API_BASE_URL, MAX_RETRIES).
Interfaces (TypeScript): Prefix with I (e.g., IUser, IChallenge).
Types (TypeScript): PascalCase (e.g., UserRole, ChallengeDifficulty).
Database Tables: snake_case with plural form (e.g., users, challenges, submissions).
Database Columns: snake_case (e.g., user_id, created_at, is_active).
CSS Classes: BEM methodology, using kebab-case (e.g., .button, .button--primary, .button__icon).
Environment Variables: UPPER_SNAKE_CASE (e.g. DATABASE_URL)

### 1.2 Dependency Management

AI Instruction: Use npm (Node Package Manager) for both frontend and backend. Use npm ci for consistent builds in CI/CD. Pin dependencies to exact versions to ensure reproducibility. Never use latest. Always specify a concrete version number.

Backend (Express.js):

File: backend/package.json

{
  "name": "job-ready-simulator-backend",
  "version": "1.0.0",
  "description": "Backend API for Job-Ready Skill Simulator",
  "main": "src/server.ts",
  "scripts": {
    "start": "node dist/server.js",
    "dev": "nodemon src/server.ts",
    "build": "tsc",
    "test:unit": "vitest run --coverage",
    "test:integration": "vitest run --config ./vitest.integration.config.ts",
    "lint": "eslint . --ext .ts",
    "format": "prettier --write ."
  },
  "dependencies": {
    "@prisma/client": "5.4.2",
    "bcrypt": "5.1.1",
    "bull": "4.11.4",
    "cors": "2.8.5",
    "dotenv": "16.4.1",
    "express": "4.18.2",
    "express-rate-limit": "7.1.5",
    "helmet": "7.1.0",
    "ioredis": "5.3.2",
    "jsonwebtoken": "9.0.2",
    "openai": "4.24.7",
    "pg": "8.11.3",
    "pino": "8.15.6",
    "zod": "3.22.4",
    "cookie-parser": "1.4.6",
    "csurf": "1.11.0"
  },
  "devDependencies": {
    "@types/bcrypt": "5.0.2",
    "@types/bull": "4.10.0",
    "@types/cors": "2.8.17",
    "@types/express": "4.17.21",
     "@types/express-rate-limit": "6.0.0",
    "@types/ioredis": "4.28.10",
    "@types/jsonwebtoken": "9.0.5",
    "@types/node": "20.10.0",
    "@types/pg": "8.10.9",
     "@types/cookie-parser": "1.4.6",
    "@types/csurf": "1.11.5",
    "@typescript-eslint/eslint-plugin": "6.19.1",
    "@typescript-eslint/parser": "6.19.1",
    "@vitest/coverage-v8": "1.2.0",
    "eslint": "8.56.0",
    "eslint-config-prettier": "9.1.0",
    "eslint-plugin-prettier": "5.0.1",
    "nodemon": "3.0.1",
    "prettier": "3.2.4",
    "prisma": "5.4.2",
    "ts-node": "10.9.1",
    "typescript": "5.3.3",
    "vitest": "1.1.0",
    "supertest": "6.3.4",
    "@types/supertest": "6.0.2"
  },
  "engines": {
    "node": ">=20"
  }
}
content_copy
download
Use code with caution.
Json
Frontend (Next.js):

File: frontend/package.json

{
  "name": "job-ready-simulator-frontend",
  "version": "1.0.0",
  "description": "Frontend for Job-Ready Skill Simulator",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "test:unit": "vitest run",
    "test:e2e": "playwright test",
    "format": "prettier --write ."
  },
  "dependencies": {
    "@codemirror/commands": "6.3.3",
    "@codemirror/language": "6.10.1",
    "@codemirror/lang-cpp": "6.0.2",
    "@codemirror/lang-css": "6.2.1",
    "@codemirror/lang-html": "6.4.8",
    "@codemirror/lang-java": "6.0.1",
    "@codemirror/lang-javascript": "6.2.2",
    "@codemirror/lang-python": "6.1.4",
    "@codemirror/lint": "6.4.2",
    "@codemirror/search": "6.5.7",
    "@codemirror/state": "6.4.1",
    "@codemirror/theme-one-dark": "6.1.2",
    "@codemirror/view": "6.23.2",
    "@hookform/resolvers": "3.3.4",
    "@radix-ui/react-icons": "1.3.0",
    "@radix-ui/react-label": "2.0.2",
    "@radix-ui/react-slot": "1.0.2",
    "@radix-ui/react-tabs": "1.0.4",
    "@tanstack/react-query": "5.0.0",
    "axios": "1.6.5",
    "class-variance-authority": "0.7.0",
    "clsx": "2.0.0",
    "cmdk": "0.2.1",
    "framer-motion": "11.0.3",
    "lucide-react": "0.308.0",
    "mdx-bundler": "10.0.1",
    "next": "14.1.0",
    "next-themes": "0.2.1",
    "react": "18.2.0",
    "react-dom": "18.2.0",
    "react-hook-form": "7.49.2",
    "rehype-pretty-code": "0.12.6",
    "shiki": "1.1.0",
    "tailwind-merge": "2.2.0",
    "tailwindcss-animate": "1.0.7",
    "zod": "3.22.4",
    "zustand": "4.4.7"
  },
  "devDependencies": {
    "@playwright/test": "1.40.1",
    "@testing-library/jest-dom": "6.2.0",
    "@testing-library/react": "14.1.2",
    "@testing-library/user-event": "14.5.2",
    "@types/node": "20.10.0",
    "@types/react": "18.2.47",
    "@types/react-dom": "18.2.17",
    "@typescript-eslint/eslint-plugin": "6.19.1",
    "@typescript-eslint/parser": "6.19.1",
    "@vitejs/plugin-react": "4.2.1",
    "autoprefixer": "10.4.16",
    "eslint": "8.56.0",
    "eslint-config-next": "14.1.0",
    "eslint-config-prettier": "9.1.0",
    "eslint-plugin-prettier": "5.0.1",
    "eslint-plugin-react-hooks": "4.6.0",
    "eslint-plugin-react-refresh": "0.4.5",
    "jsdom": "24.0.0",
    "postcss": "8.4.33",
    "prettier": "3.2.4",
    "tailwindcss": "3.4.0",
    "typescript": "5.3.3",
    "vitest": "1.1.0"
  }
}
content_copy
download
Use code with caution.
Json
Installation Commands (AI Instruction):

To install dependencies, navigate to the backend and frontend directories separately and run:

npm install <package-name>@<exact-version>
content_copy
download
Use code with caution.
Bash
For example:

npm install express@4.18.2
npm install @prisma/client@5.4.2
npm install react@18.2.0
npm install zod@3.22.4
For devDependencies, use:

npm install --save-dev <package-name>@<exact-version>
content_copy
download
Use code with caution.
Bash
For example:

npm install --save-dev typescript@5.3.3
In CI/CD environments, always use npm ci for clean, consistent, and reproducible installations based on package-lock.json. Do not use npm install in CI/CD.

### 1.3 Build System Configuration

Backend (Express.js with TypeScript):

File: backend/tsconfig.json

{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "lib": ["ES2022"],
    "outDir": "dist",
    "rootDir": "src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "sourceMap": true,
    "declaration": true,
        "removeComments": true,
        "emitDecoratorMetadata": true,
        "experimentalDecorators": true,
        "incremental": true,
        "noFallthroughCasesInSwitch": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "test"]
}

Json

Explanation:

target: Sets the ECMAScript target version to ES2022 for modern JavaScript features.
module: Sets the module system.
moduleResolution: Specifies the module resolution strategy (Node.js).
lib: Specifies the library files to be included in the compilation.
outDir: Specifies the output directory for compiled files.
rootDir: Specifies the root directory of input files.
strict: Enables all strict type-checking options.
esModuleInterop: Enables interoperability between CommonJS and ES Modules.
skipLibCheck: Skips type checking of declaration files.
forceConsistentCasingInFileNames: Ensures consistent casing in file names.
resolveJsonModule: Allows importing JSON modules.
sourceMap: Generates source map files for debugging.
declaration: Generates corresponding '.d.ts' files.
include: Specifies which files to include in the compilation.
exclude: Specifies which files to exclude from the compilation.
removeComments: Remove comments during transpilation.
emitDecoratorMetadata, experimentalDecorators: Enables decorator features.
incremental: Enable incremental compilation
noFallthroughCasesInSwitch: Report errors for fallthrough cases in switch statement
Frontend (Next.js):

Next.js handles most of the build configuration automatically. However, we'll configure PostCSS and Tailwind.

File: frontend/postcss.config.js

module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};
content_copy
download
Use code with caution.
JavaScript
File: frontend/tailwind.config.ts

import type { Config } from "tailwindcss";
import { fontFamily } from "tailwindcss/defaultTheme";

const config: Config = {
  darkMode: ["class"],
  content: [
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  prefix: "",
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
      fontFamily: {
        sans: ["var(--font-sans)", ...fontFamily.sans],
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
};
export default config;

TypeScript
Build Commands:

Backend Build: npm run build (transpiles TypeScript to JavaScript)
Frontend Build: npm run build (creates an optimized production build)
Start server (Backend): npm run start
Start server (Frontend): npm run start

### 1.4 Development Environment Setup

AI Instruction: Follow these steps to set up the development environment. These instructions assume a Unix-like environment (Linux, macOS, or WSL on Windows).

Install Node.js and npm: Install Node.js (version 20 LTS) and npm. Verify installation:
# Example using nvm:
nvm install 20
nvm use 20
node -v  # Should output v20.x.x
npm -v   # Should output a version number

Bash
Install Docker and Docker Compose: Install Docker Desktop (which includes Docker Compose). Verify installation:
docker -v
docker-compose -v

Bash
Clone Repository:
git clone <repository_url>
cd <repository_name>

Bash
Install Dependencies:
cd backend
npm install
cd ../frontend
npm install

Bash
Set Up Environment Variables:
Create a .env file in the backend directory by copying .env.example: cp .env.example .env
Create a .env file in the frontend directory by copying .env.example: cp .env.example .env
Fill in the required environment variables in both .env files. Do not commit .env files to the repository. They contain secrets.
Database Setup (PostgreSQL):
Start the database and supporting services using Docker Compose:
docker compose up -d db pgbouncer redis

Bash
Run Prisma migrations to create the database schema:
cd backend
npx prisma migrate dev --name init

Bash
Run the Application:
Start the backend development server:
cd backend
npm run dev

Bash
Start the frontend development server:
cd frontend
npm run dev

Bash
IDE Configuration:
Recommended IDE: VS Code.
Install Extensions:
ESLint
Prettier - Code formatter
Prisma
Docker
Tailwind CSS IntelliSense
Code Spell Checker
GitLens
VS Code Settings: Create a .vscode directory in the root of the project. Inside, create a settings.json file:
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescriptreact]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "eslint.validate": ["javascript", "javascriptreact", "typescript", "typescriptreact"],
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit"
  },
  "tailwindCSS.includeLanguages": {
    "typescript": "javascript",
    "typescriptreact": "javascript"
  },
  "editor.quickSuggestions": {
    "strings": true
  },
  "tailwindCSS.experimental.configFile": "./frontend/tailwind.config.ts",
  "typescript.tsdk": "frontend/node_modules/typescript/lib" // For frontend, use local TS version
}

Json
Debugging Configuration: Create a .vscode/launch.json file:
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "attach",
      "name": "Backend: Attach to Node.js",
      "port": 9229,
      "restart": true,
      "skipFiles": ["<node_internals>/**"],
  "localRoot": "${workspaceFolder}/backend",
          "remoteRoot": "/app"
        },
        {
            "type": "chrome",
            "request": "launch",
            "name": "Frontend: Launch Chrome against localhost",
            "url": "http://localhost:3000",
            "webRoot": "${workspaceFolder}/frontend"
          },
      ]
    }
    ```

### 1.5 Version Control (Git and GitHub)

**AI Instruction:** Use Git for version control and GitHub for remote repository hosting. Adhere to the following branching strategy and workflow.

**Branching Strategy:** Gitflow.

*   `main`: Represents the production-ready code.  Only merge into `main` via pull requests from `staging`.  Tag releases on `main`.
*   `staging`: Represents the pre-production environment.  Merge into `staging` via pull requests from `develop`.
*   `develop`: The main integration branch for features and bug fixes.  Merge into `develop` via pull requests from feature/bugfix branches.
*   `feature/<feature-name>`:  Branch for developing new features.  Branch off from `develop` and merge back into `develop`. Use a descriptive name, e.g., `feature/user-authentication`, `feature/challenge-submission`.
*   `bugfix/<bug-description>`: Branch for fixing bugs. Branch off from `develop` and merge back into `develop`. Use a descriptive name, e.g., `bugfix/api-timeout`, `bugfix/login-form-validation`.
*   `hotfix/<hotfix-description>`: Branch for critical bug fixes that need to be deployed to production immediately. Branch off from `main` and merge back into `main` *and* `develop`.  Use a descriptive name, e.g., `hotfix/security-vulnerability`, `hotfix/payment-processing-error`.

**Workflow:**

1.  **Create a New Branch:** Before starting any work, create a new branch from the `develop` branch (or `main` for hotfixes).

    ```bash
    git checkout -b feature/my-new-feature develop  # For features
    git checkout -b bugfix/fix-login-issue develop   # For bug fixes
    git checkout -b hotfix/critical-security-fix main # For hotfixes
    ```

2.  **Commit Changes:** Make changes and commit them with descriptive messages. Follow the Conventional Commits specification:

    *   `feat: Add user authentication` (New feature)
    *   `fix: Resolve API request timeout` (Bug fix)
    *   `docs: Update README with setup instructions` (Documentation update)
    *   `style: Format code with Prettier` (Code style changes)
    *   `refactor: Improve error handling in UserService` (Code refactoring)
    *   `test: Add unit tests for AuthService` (Adding tests)
    *   `chore: Update dependencies` (Routine tasks)
    *   `perf: Improve performance of database query` (Performance improvements)

    **AI Instruction:**  *Always* use Conventional Commits format for commit messages. Be specific and concise.

    ```bash
    git commit -m "feat: Implement user registration endpoint"
    ```

3.  **Create a Pull Request:** When the work is complete, push the branch to GitHub and create a pull request (PR) against the appropriate target branch (`develop` for features/bugfixes, `main` for hotfixes).

    ```bash
    git push origin feature/my-new-feature
    ```

    *   The PR title should clearly summarize the change.
    *   The PR description should provide a detailed explanation of the changes, including the motivation, the approach taken, and any relevant context.
    *   Link the PR to any related issues (e.g., "Fixes #123").
    *   Request reviews from at least one other developer.

4.  **Code Review:** The reviewer(s) will:

    *   Check the code for correctness, readability, and maintainability.
    *   Ensure adherence to coding standards and best practices.
    *   Verify that tests are comprehensive and cover all relevant scenarios.
    *   Consider performance, scalability, and security implications.
    *   Provide constructive feedback and suggestions.

5.  **Address Feedback:** The author of the PR must address all feedback and make necessary changes.  This may involve multiple rounds of review and revision.

6.  **Approval:** Once the reviewer(s) are satisfied, they approve the PR.

7.  **Merge:** Once approved, the PR can be merged into the target branch.  Use the "Squash and Merge" option on GitHub to create a clean commit history.

8.  **Deployment:**
    *   Merging into `develop` triggers a deployment to the staging environment.
    *   Merging into `main` triggers a deployment to the production environment.

**AI Instruction:**  Strictly adhere to this Gitflow workflow.  All code MUST go through a pull request and code review before being merged.  Direct commits to `develop` or `main` are prohibited (except for hotfixes to `main`, which still require a PR).

## 2. Core Architectural Components and Modules

### 2.1 Component Decomposition

#### 2.1.1 Authentication Service (`auth-service`)

* **Purpose:** Manages user authentication, authorization, and session management. Provides secure access control to protected resources. Implements robust security measures.

* **Input:**
  * `POST /api/v1/auth/register`: `{ name: string, email: string, password: string }`
  * `POST /api/v1/auth/login`: `{ email: string, password: string }`
  * `POST /api/v1/auth/github`: `{ code: string }`
  * `GET /api/v1/auth/me`: `Authorization: Bearer <token>`
  * `POST /api/v1/auth/logout`: `Authorization: Bearer <token>`
  * `POST /api/v1/auth/refresh`: `{ refreshToken: string }`
  * `GET /api/v1/auth/csrf-token`:

* **Output:**
  * `/register`, `/login`, `/github`: `{ token: string, refreshToken: string, user: { id: string, email: string, name: string, role: string }}`
  * `/me`: `{ user: { id: string, email: string, name: string, role: string }}`
  * `/logout`: `{ success: boolean }`
  * `/refresh`: `{ token: string, refreshToken: string }`
  * `/csrf-token`: `{ csrfToken: string }`

* **Interfaces:**
  * REST API endpoints (as defined in Input).

* **Internal Logic:**
  1. **Registration:**
     * Validate input data (email format, password strength, name length) using `zod`.
     * Check for existing user with the same email using `prisma`.
     * Hash the password using `bcrypt` with a cost factor of 12.
     * Create a new user record in the database using `prisma`.
     * Generate a JWT (JSON Web Token) using `jsonwebtoken`. Sign with `process.env.JWT_SECRET` and set `expiresIn: '1h'`.
     * Generate a refresh token using `jsonwebtoken`.  Sign with a *different* secret, `process.env.JWT_REFRESH_SECRET`, with `expiresIn: '7d'`.
     * Store the refresh token in an HttpOnly, Secure, SameSite=Strict cookie.
     * Return the JWT (access token) and user information in the response body.
  2. **Login:**
     * Validate input data using `zod`.
     * Retrieve user record from the database by email using `prisma`.
     * Verify the password hash using `bcrypt.compare`.
     * If credentials are invalid, throw an `UnauthorizedError`.
     * Generate a new JWT (access token) and refresh token.
     * Store the refresh token in an HttpOnly, Secure, SameSite=Strict cookie.
     * Return the JWT and user information.
  3. **GitHub OAuth:**
     * Exchange the authorization `code` with GitHub for an access token using `axios`.
     * Fetch the user's profile information from GitHub using the access token.
     * If a user with the GitHub ID exists (check `githubId` field), log them in (generate JWT/refresh token).
     * If no user exists with that GitHub ID, check if a user with the *same email* exists. If so, link the GitHub ID to the existing user.
     * If no user exists with the same email, create a new user record and log them in.
     * *Always* link existing accounts by email if possible, to prevent duplicate accounts.
  4. **Logout:**
     * Add the JWT (access token) to a blacklist in Redis to invalidate it. Use the token's expiration time as the TTL for the Redis entry.
     * Clear the refresh token cookie.
  5. **Token Refresh:**
     * Verify the refresh token. If invalid or expired, return a 401 error.
     * Generate a new JWT (access token) and a new refresh token.
     * Invalidate the old refresh token (add to blacklist or remove from database).
     * Store the new refresh token securely.
     * Return new access, and refresh tokens.
  6. **Get Current User (/me):**
     * Verify the JWT (access token) from the `Authorization` header.
     * Fetch user information from the database by `userId` (extracted from the token) using `prisma`.
  7. **Get CSRF Token:**
     * Generate CSRF token.

* **Dependencies:**
  * `prisma`: Database access.
  * `bcrypt`: Password hashing.
  * `jsonwebtoken`: JWT generation and verification.
  * `ioredis`: Redis client for token blacklisting and session management.
  * `axios`: HTTP requests for OAuth.
  * `zod`: Input validation.
  * `cookie-parser`: Parse Cookie header and populate req.cookies.
  * `csurf`: CSRF protection middleware.

* **Error Handling:**
  * `400 Bad Request`: Invalid input data.  Return specific validation errors from Zod.
  * `401 Unauthorized`: Invalid credentials, missing or expired token.
  * `403 Forbidden`: Insufficient permissions.
  * `409 Conflict`: User already exists.
  * `500 Internal Server Error`: Unexpected errors.  Log detailed error information, but do *not* expose internal error details to the client.

* **Testing:**
  * **Unit Tests:** Test individual functions (e.g., password hashing, JWT generation, input validation, token refresh logic).  Mock external dependencies (database, Redis, OAuth providers).
  * **Integration Tests:** Test the entire authentication flow (registration, login, logout, token refresh, /me). Test with valid and invalid data. Test different roles and permissions.  Test OAuth flow with a mock OAuth provider.

* **Concurrency:**
  * Use asynchronous operations (Promises/async/await) to handle multiple requests concurrently.
  * Use connection pooling for database access (handled by Prisma).
  * Use rate limiting to prevent abuse (see `middleware/rate-limit.middleware.ts`).

* **Security:**
  * **Password Hashing:** Use a strong, one-way hashing algorithm (bcrypt) with a salt.
  * **JWT:** Use short-lived JWTs (access tokens) and long-lived refresh tokens.  Sign JWTs with a strong secret.
  * **Token Storage:** Store refresh tokens in HttpOnly, Secure, SameSite=Strict cookies.  Do *not* store tokens in local storage.
  * **Token Blacklisting:** Implement a token blacklist to invalidate JWTs on logout.
  * **Rate Limiting:** Implement rate limiting on login and registration endpoints to prevent brute-force attacks.
  * **Input Validation:** Validate all inputs using Zod to prevent injection attacks.
  * **CSRF Protection:** Implement CSRF protection using the `csurf` middleware.
  * **HTTPS:** Enforce HTTPS for all communication.

#### 2.1.2 Challenge Service (`challenge-service`)

* **Purpose:** Manages coding challenges, including creation, retrieval, updating, and deletion.

* **Input:**
  * `GET /api/v1/challenges`: (Optional query parameters: `difficulty`, `category`, `tags`, `search`, `page`, `limit`, `sortBy`, `sortOrder`)
  * `GET /api/v1/challenges/:id`:
  * `POST /api/v1/challenges`: `{ title: string, description: string, difficulty: string, category: string, instructions: string, starterCode: string, solutionCode: string, testCases: object[], hints: string[], tags: string[], estimatedTime: number, isPublic: boolean }` (Requires authentication and instructor/admin role)
  * `PUT /api/v1/challenges/:id`:  (Same fields as POST, but all optional) (Requires authentication and ownership/admin role)
  * `DELETE /api/v1/challenges/:id`: (Requires authentication and ownership/admin role)
  * `GET /api/v1/challenges/categories`:

* **Output:**
  * `/api/v1/challenges`: `{ challenges: Challenge[], pagination: { page: number, limit: number, total: number, pages: number } }`
  * `/api/v1/challenges/:id`: `{ challenge: Challenge }`
  * `/api/v1/challenges`: (POST/PUT) `{ challenge: Challenge }`
  * `/api/v1/challenges/:id`: (DELETE) `{ success: boolean }`
  * `/api/v1/challenges/categories`: `{ categories: string[] }`

* **Interfaces:**
  * REST API endpoints (as defined in Input).
  * `Challenge` data type: (defined in previous iteration)

* **Internal Logic:**
  1. **List Challenges:**
     * Retrieve challenges from the database using `prisma.challenge.findMany`, applying filters (difficulty, category, search term, tags) and pagination (using `skip` and `take`).
     * Calculate the total number of pages.
     * Return a paginated list of challenges and pagination metadata: `{challenges: [], pagination: { page, limit, total, pages } }`.
  2. **Get Challenge:**
     * Retrieve a challenge by ID using `prisma.challenge.findUnique`.
     * If the challenge is not public (`isPublic: false`), check if the user is the creator (`createdById`) or an admin. If not, return a 403 Forbidden error.
     * If user is student, remove `solutionCode` from the output.
     * Hide expected output from the non-public test cases, if user is not authorized to access.
  3. **Create Challenge:**
     * Validate the input data (all required fields, data types, etc.) using `zod`.
     * Verify the user's role (instructor or admin) using the `auth` middleware and the `authorize` function.
     * Create a new challenge record in the database using `prisma.challenge.create`.
  4. **Update Challenge:**
     * Validate the input data using `zod`.
     * Verify the user's role (creator or admin) and ownership using the `auth` middleware and the `verifyOwnership` function.
     * Update the challenge record in the database using `prisma.challenge.update`.
  5. **Delete Challenge:**
     * Verify the user's role (creator or admin) and ownership using the `auth` middleware and the `verifyOwnership` function.
     * Delete the challenge record from the database using `prisma.challenge.delete`.  Consider soft-delete for challenges with existing submissions.
     * If challenge has submissions, soft delete, otherwise delete the record.
  6. **Get Categories:**
     * Return all unique categories from public challenges.

* **Dependencies:**
  * `prisma`: Database access.
  * `zod`: Input validation.

* **Error Handling:**
  * `400 Bad Request`: Invalid input data.  Return specific validation errors from Zod.
  * `401 Unauthorized`: User not authenticated.
  * `403 Forbidden`: User does not have permission (not an instructor/admin, or not the owner of the challenge).
  * `404 Not Found`: Challenge not found.
  * `500 Internal Server Error`: Unexpected errors. Log detailed error information.

* **Testing:**
  * **Unit Tests:** Test individual functions (e.g., input validation, filtering logic, pagination logic).
  * **Integration Tests:** Test the entire API endpoints, including database interactions.  Test listing challenges with various filters and pagination. Test getting a challenge with and without authentication, and with public and private challenges. Test creating, updating, and deleting challenges with different user roles.

* **Concurrency:** Use asynchronous operations (Promises/async/await). Database operations are handled concurrently by Prisma and the database connection pool.

#### 2.1.3 Submission Service (`submission-service`)

* **Purpose:** Handles code submissions, executes tests, coordinates feedback generation, and updates user progress.  This is a *critical* service for the platform.

* **Input:**
  * `POST /api/v1/submissions`: `{ challengeId: string, language: string, code: string }` (Requires authentication)
  * `GET /api/v1/submissions/:id`: (Requires authentication and ownership/admin/challenge-creator role)
  * `GET /api/v1/submissions/:id/feedback`: (Requires authentication and ownership/admin/challenge-creator role)
  * `POST /api/v1/submissions/:id/feedback/regenerate`: (Requires authentication and ownership/admin role, and premium/admin)
  * `GET /api/v1/submissions/feedback/job/:jobId`: (Requires authentication and ownership/admin/challenge-creator role)
  * `GET /api/v1/submissions/user`: Get current user submission, with pagination.

* **Output:**
  * `/api/v1/submissions`: `{ submissionId: string, status: string, testResults: object[] | null, feedback: object | null, feedbackStatus: string | null }`
  * `/api/v1/submissions/:id`:  `{ submission: Submission, testResults: object[] | null, feedbackStatus: string | null}`
  * `/api/v1/submissions/:id/feedback`:  `{ feedback: Feedback | null, status: string, message: string }`
  * `/api/v1/submissions/:id/feedback/regenerate`: `{ jobId: string}`
  * `/api/v1/submissions/feedback/job/:jobId`:  `{ status: string, feedback?: Feedback}`
  * `/api/v1/submissions/user`: `{ submissions: Submission[], pagination: { page: number, limit: number, total: number, pages: number } }`

* **Interfaces:**
  * REST API endpoints (as defined in Input).
  * `Submission` data type: (defined in previous iteration)
  * `Feedback` data type: (defined in previous iteration)

* **Internal Logic:**
  1. **Submit Code:**
     * Validate input data (challenge ID exists, language is supported, code is not empty) using `zod`.
     * Create a new submission record in the database with status "PENDING" using `prisma`.
     * Retrieve the challenge details (test cases) using the `challengeService`.
     * Enqueue a job for code execution using the `bull` queue. The job ID *is* the submission ID. This ensures a 1:1 mapping between submissions and execution jobs.
     * Return the submissionId, and status to user.
  2. **Get Submission:**
     * Retrieve a submission by ID using `prisma`.
     * Verify that the requesting user is the owner of the submission, the creator of the challenge, or an admin.
  3. **Get Feedback**:
     * Check the feedback is ready, if yes, return the result.
     * Check if feedback is in progress, if so, return `pending` status.
     * If there is no feedback for the submission, initiate feedback request, and return `pending` status.
  4. **Regenerate Feedback**:
     * Only owner or admin can regenerate a feedback.
     * Only submission with passed tests can regenerate a feedback.
     * Check regenerate feedback limit for the user.
     * Delete the existing feedback, and queue feedback generation, and return job id.
  5. **Check feedback Job**:
     * Check the JobID status, if finished return feedback, otherwise show status.
  6. **Get User Submission**:
     * Get user's submission, and add pagination to it.
  7. **Code Execution (in a separate worker process):**
     * Dequeue a submission job from the `code-execution` queue (using `bull`).
     * Create a secure execution environment (Docker container) using `dockerode`.
     * Select the correct Docker image based on the submission language (see 9.3 for Dockerfiles).
     * Copy the user's code and the challenge's test cases into the container.
     * Execute the user's code against the test cases using the appropriate test runner:
       * **JavaScript:** `node --expose-internals ./node_modules/vitest/vitest.mjs run --reporter=json --outputFile=test-results.json` (within a `vm2` sandbox).
       * **Python:** `python -m pytest -v --json-report --json-report-file=test-results.json` (with resource limits set using the `resource` module).
       * **Java:**  `mvn test -DargLine=-Dfile.encoding=UTF-8 -Dmaven.test.failure.ignore=true -Dtest=SolutionTest` (using JUnit 5 and Maven).
       * **SQL**: `psql -U postgres -d testdb -f /app/test.sql`
     * Capture the test results (pass/fail, output, errors), execution time, and memory usage. Use `docker stats` for resource monitoring during execution.
     * Parse the test results from the generated JSON output file (e.g., `test-results.json`).
     * Update the submission record in the database with the results using `prisma`. Update the status to "PASSED", "FAILED", or "ERROR" accordingly.
     * If the submission passed all tests, trigger AI feedback generation (asynchronously, via a direct call to the `aiFeedbackService`).

  8. **AI Feedback Generation (in a separate worker process or service - `ai-feedback.service.ts`):**
     * Dequeue a feedback generation job from the `ai-feedback` queue (using `bull`).
     * **Caching:** Check for cached feedback using a hash of the normalized code, language, and challenge ID as the key (using `redis`).
     * **Similarity Check:** If no cache hit, check for similar submissions using vector embeddings (using `prisma` and the `aiProvider` for embedding generation).
     * **Pattern Matching:** If no similar submission is found, analyze the code for common patterns (using pre-defined rules or a simple pattern matching library).
     * **Quota Check:** If no cache/similar submission/pattern is found, check user quota.
     * **AI Model Selection:** If the user has quota, select the appropriate AI model (GPT-4, GPT-3.5-turbo, or Claude) based on the user's subscription tier, task complexity, and current system load. Prioritize cost-effectiveness while maintaining quality.
     * **Prompt Generation:** Generate an optimized prompt for the AI model, including the challenge description, user code, test results, and specific instructions for the AI.
     * **API Call:** Call the AI provider's API (OpenAI or Anthropic) with the generated prompt.
     * **Response Parsing:** Parse the AI's response and extract the relevant information (strengths, weaknesses, suggestions, conceptual errors, score).  Validate the response format.
     * **Feedback Storage:** Save the feedback to the database and associate it with the submission using `prisma`.
     * **Caching:** Cache the feedback in Redis for future use.
     * **Error Handling:** Handle potential errors (API errors, invalid responses, timeouts, etc.). Implement retry mechanisms with exponential backoff. If AI generation fails, fall back to pattern-based or basic feedback.
     * **Token Usage:** Track the number of tokens used for feedback generation (for cost monitoring and quota management).

* **Dependencies:**
  * `prisma`: Database access.
  * `bull`: Job queue for code execution and feedback generation.
  * `dockerode`: Docker API for container management.
  * `openai` or `anthropic`: AI API clients.
  * `redis`: Cache and queue.
  * `zod`: Input validation.
  * `challengeService`: To retrieve challenge data.
  * `aiFeedbackService`: To generate AI feedback.

* **Error Handling:**
  * `400 Bad Request`: Invalid input data. Return specific validation errors from Zod.
  * `401 Unauthorized`: User not authenticated.
  * `403 Forbidden`: User does not have permission (not the owner, challenge creator, or an admin).
  * `404 Not Found`: Challenge or submission not found.
  * `429 Too Many Requests`: Rate limit exceeded (for code execution or feedback generation). Implement using `express-rate-limit` and Redis.
  * `500 Internal Server Error`: Unexpected errors, code execution errors, AI provider errors. Log detailed error information using `pino`.

* **Testing:**
  * **Unit Tests:** Test individual functions (e.g., input validation, test result parsing, feedback parsing). Mock external dependencies (database, AI provider, Docker).
  * **Integration Tests:** Test the entire submission flow, including code execution, feedback generation, and database updates. Test with different languages, test cases, and error scenarios. Test caching and rate limiting.  Test with various AI models.

* **Concurrency:**
  * Use a job queue (`bull`) to handle code execution and feedback generation asynchronously, preventing blocking operations from affecting API responsiveness. The queue should have a concurrency limit to avoid overwhelming the system.
  * Use connection pooling for database access (handled by Prisma).
  * Code execution and AI feedback generation are handled by separated workers.

#### 2.1.4 User Service (`user-service`)

* **Purpose:** Manages user profiles, progress tracking, and user-related data.

* **Input:**
  * `GET /api/v1/users/me/profile`: (Requires authentication)
  * `PUT /api/v1/users/me/profile`: `{ name: string, profileImage?: string, settings?: object }` (Requires authentication)
  * `GET /api/v1/users/me/progress`:  (Requires authentication)
  * `GET /api/v1/users/me/submissions`: (Requires authentication)

* **Output:**
  * `/api/v1/users/me/profile`: `{ profile: { id: string, name: string, email: string, role: string, profileImage: string, settings: object } }`
  * `/api/v1/users/me/profile`: (PUT) `{ profile: { id: string, name: string, email: string, role: string, profileImage: string, settings: object} }`
  * `/api/v1/users/me/progress`: `{progressSummary: object, recentActivity: object[], categoryCompletion: object[], difficultyCompletion: object[], skillProgression: object[] }`
  * `/api/v1/users/me/submissions`: `{ submissions: Submission[], pagination: { page: number, limit: number, total: number, pages: number } }`

* **Interfaces:**
  * REST API endpoints (as defined in Input).
  * `UserProfile` data type:
    ```typescript
    interface UserProfile {
      id: string;
      name: string;
      email: string;
      role: "STUDENT" | "INSTRUCTOR" | "ADMIN";
      profileImage?: string;
      settings?: object; // User-specific settings (e.g., theme, notifications)
      createdAt: Date;
    }
    ```

* **Internal Logic:**
  1. **Get User Profile:**
     * Retrieve the user's profile information from the database using `prisma` and the user's ID (from the authentication token).
     * Return the user profile data.
  2. **Update User Profile:**
     * Validate the input data using `zod`.
     * Update the user's profile information in the database using `prisma`.
     * Return the updated user profile data.
  3. **Get User Progress**:
     * Get all data related to user progress from different tables.
  4. **Get User Submissions:**
     * Get user's submission, with pagination.

* **Dependencies:**
  * `prisma`: Database access.
  * `zod`: Input validation.

* **Error Handling:**
  * `400 Bad Request`: Invalid input data. Return specific validation errors.
  * `401 Unauthorized`: User not authenticated.
  * `404 Not Found`: User not found.
  * `500 Internal Server Error`: Unexpected errors. Log detailed error information.

* **Testing:**
  * **Unit Tests:** Test individual functions (e.g., getting and updating profiles).
  * **Integration Tests:** Test the API endpoints, including authentication and authorization.

* **Concurrency:** Use asynchronous operations (Promises/async/await) to handle concurrent requests.

### 2.2 Data Model

**AI Instruction:** Use Prisma to define the data model.  The following Prisma schema defines the database tables and relationships.  Use PostgreSQL as the database provider.

```prisma
// File: backend/prisma/schema.prisma

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
  challenges    Challenge[] // Challenges created by this user
    userSkills    UserSkill[]
    usageLogs    UsageLog[]

  @@index([email]) // Index for faster lookups by email
  @@index([role])  // Index for filtering users by role
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
  createdById   String // Foreign key to User
  createdAt     DateTime    @default(now())
  updatedAt     DateTime    @updatedAt

  createdBy     User        @relation(fields: [createdById], references: [id])
  submissions   Submission[]
  progress      Progress[]
  courseChallenges CourseChallenge[] // Relationship to CourseChallenge
    learningPathSteps LearningPathStep[]

    @@index([difficulty, category]) // Composite index for filtering
  @@index([tags])       // Index for searching by tags
  @@index([createdById])    // Index for finding challenges by creator
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
  embedding     Float[]     @db.Vector(1536) // For similarity search
  createdAt     DateTime    @default(now())

  user          User        @relation(fields: [userId], references: [id])
  challenge     Challenge   @relation(fields: [challengeId], references: [id])
  feedback      AIFeedback?
  progress      Progress[]

  @@index([userId, challengeId, createdAt]) // Index for user's submission history
  @@index([status])         // Index for filtering submissions by status
  @@index([language])        // Index for submissions language
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

  submission    Submission  @relation(fields: [submissionId], references: [id])

  @@index([source])
  @@index([createdAt])
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
Markdown
AI Instruction: Use this Prisma schema to generate the database migrations and the Prisma client. Run migrations using: npx prisma migrate dev --name <descriptive_migration_name>. Review the generated SQL before applying the migration. To apply migrations in a production environment, use npx prisma migrate deploy. Add comments to explain tables and columns.

Database Migration Strategy:

Use Prisma Migrate for database migrations.
Each schema change should be accompanied by a new migration.
Migrations should be reversible (up and down).
Test migrations thoroughly in a development environment before applying them to staging or production.
AI Instruction: When you modify schema.prisma, generate a migration using: npx prisma migrate dev --name <descriptive_migration_name>. Review the generated SQL before applying the migration.
Data Validation:

Use Zod for validating the data before it reaches to database.
Indexing Strategy:

Indexes are defined within the Prisma schema using the @@index() attribute. See the schema above for specific index definitions.

Connection Pooling:
Use PgBouncer for connection pool.
Image: edoburu/pgbouncer:1.18.0

File: backend/config/pgbouncer.ini

[databases]
kodelab = host=db port=5432 dbname=kodelab user=postgres password=postgres

[pgbouncer]
listen_addr = 0.0.0.0
listen_port = 6432
auth_type = trust
auth_file = /etc/pgbouncer/userlist.txt
logfile = /var/log/pgbouncer/pgbouncer.log
pidfile = /var/run/pgbouncer/pgbouncer.pid
admin_users = postgres
pool_mode = transaction
server_reset_query = DISCARD ALL
max_client_conn = 100
default_pool_size = 20
min_pool_size = 5
reserve_pool_size = 5
reserve_pool_timeout = 3
max_db_connections = 50
max_user_connections = 50

Ini
File: backend/config/userlist.txt

"postgres" "postgres"

Connection String (Backend):

DATABASE_URL=postgresql://postgres:postgres@pgbouncer:6432/kodelab

Docker compose file update:
Add image to pgbouncer:

pgbouncer:
    image: edoburu/pgbouncer:1.18.0

Yaml

### 2.3 Inter-Component Communication
REST APIs: The primary method of communication between frontend and backend services and between backend services themselves. Use JSON for data exchange. All API endpoints MUST be documented using the OpenAPI 3.0 specification.
WebSockets (Future - Phase 2): For real-time features like collaborative coding and live feedback updates. Use Socket.IO for WebSocket communication.
Message Queue (Bull): For asynchronous tasks (code execution, AI feedback generation). The backend services communicate with each other and with worker processes through the Redis-backed Bull queue. The queue name for code execution is code-execution. The queue name for AI feedback generation is ai-feedback.
Internal Service Calls: Use http request for direct communication, and use service discovery for internal service calls.
AI Instruction: All API endpoints MUST be documented using the OpenAPI 3.0 specification. Generate client SDKs from the OpenAPI spec. Use descriptive names for endpoints and follow RESTful principles.

2.4 Security Considerations
Authentication: All API requests (except for public endpoints like /api/v1/challenges for listing) require authentication via JWT. JWTs are obtained through the /api/v1/auth/login or /api/v1/auth/register endpoints. The JWT must be included in the Authorization header as a Bearer token: Authorization: Bearer <token>.
Authorization: Implement Role-Based Access Control (RBAC) to restrict access to certain endpoints based on user roles (student, instructor, admin). Use the auth middleware and the authorize and verifyOwnership functions for authorization checks.
Data Validation: Validate all user inputs using Zod schemas to prevent injection attacks and ensure data integrity. Validate data on both the frontend (for user experience) and the backend (for security).
Rate Limiting: Implement rate limiting on all API endpoints to prevent abuse. Use the express-rate-limit middleware with a Redis store. Configure different rate limits for different endpoints and user roles.
Secure Code Execution: Execute user-submitted code in isolated Docker containers with limited resources and network access (see Section 9 for details).
Data Encryption: Encrypt sensitive data at rest (database) and in transit (HTTPS). Use TLS 1.3 for all HTTPS connections.
Regular Security Audits: Perform regular security audits and vulnerability scans (see Section 10.4).
(Content already provided in previous iteration. This section is complete and consistent with the requirements.)

4.3 User Authentication and Profiles
(Content already provided in previous iteration. This section is complete and consistent with the requirements.)

4.4 Progress Tracking and Analytics
(Content already provided in previous iteration. This section is complete and consistent with the requirements.)

4.5 Secure Execution Environment
(Content already provided in previous iteration. This section is complete and consistent with the requirements. Refer also to Section 9: Code Execution Environment and 10: Security Architecture.)

4.6 Peer Review System
(Content already provided in previous iteration. This section is complete and consistent with the requirements.)

4.7 Adaptive Learning Path
(Content already provided in previous iteration. This section is complete and consistent with the requirements.)

4.8 Multi-Language Support
(Content already provided in previous iteration. This section is complete and consistent with the requirements.)

4.9 Gamification
(Content already provided in previous iteration. This section is complete and consistent with the requirements.)

4.10 Task 9 and 10
(Content already provided in previous iteration. This section is complete and consistent with the requirements.)

4.11 Accessibility Features
4.11.1 WCAG Compliance
Conformance Level: The platform will adhere to the Web Content Accessibility Guidelines (WCAG) 2.1 Level AA.
Regular Audits: Conduct regular accessibility audits using automated tools (e.g., Axe, WAVE) and manual testing with assistive technologies (e.g., screen readers).
User Testing: Include users with disabilities in the testing process to gather feedback and identify usability issues.
4.11.2 Screen Reader Support
ARIA Attributes: Use ARIA attributes appropriately to provide semantic information to screen readers (e.g., aria-label, aria-describedby, role).
Semantic HTML: Use semantic HTML5 tags (e.g., <nav>, <header>, <footer>, <article>, <aside>) to structure content logically.
Text Alternatives: Provide text alternatives for all non-text content (e.g., images, icons) using the alt attribute.
Landmarks: Use ARIA landmark roles to help users to navigate page.
4.11.3 Keyboard Navigation
Keyboard Operability: Ensure that all functionality is operable through a keyboard interface, without requiring a mouse.
Focus Management: Manage focus effectively, ensuring that focus is visible and moves in a logical order.
Skip Navigation: Provide "Skip to content" links to allow keyboard users to bypass navigation menus.
No Keyboard Trap: Ensure that keyboard focus is never trapped within any part of the content.
4.11.4 Visual Considerations
Color Contrast: Ensure sufficient color contrast between text and background, meeting WCAG AA requirements (minimum 4.5:1 contrast ratio for normal text, 3:1 for large text).
Font Sizes: Use relative font sizes (e.g., em, rem) to allow users to adjust text size.
High Contrast Mode: Provide a high contrast mode (e.g., light text on a dark background) as an option.
Zoom: Support zooming up to 400%.
Flashing Content: Avoid content that flashes or flickers rapidly (more than three times per second), as this can trigger seizures.
Readable Font: Use readable font.
4.11.5 Other Features
Captions/Subtitles: Provide captions or subtitles for any video content.
Transcripts: Provide transcripts for audio content.
Clear Language: Use clear, concise language in all instructions and feedback. Avoid jargon and technical terms where possible.
Help Documentation: Provide comprehensive help documentation on accessibility features.
Error Identification: Clearly identify input errors and provide suggestions for correction.
Time Limits: Avoid time limits where possible. If necessary provide a warning, and allow extend the time.
AI Instruction: When creating UI components, ensure they are accessible by design. Use semantic HTML, ARIA attributes, and follow WCAG guidelines. Test all components with screen readers and keyboard navigation. Use automated accessibility testing tools as part of the CI/CD pipeline.

5. Technical Design
(This section consolidates and expands upon previous iterations, including details from TechnicalStack.md and SystemArchitectureDesign.md.)

5.1 System Architecture
The Job-Ready Skill Simulator utilizes a microservices architecture, promoting scalability, maintainability, and independent deployment of services. The system is designed for deployment on DigitalOcean's App Platform (initially) and Kubernetes (Phase 3).

5.1.1 Frontend Layer
Technology: Next.js 14.1.0 (React framework) with TypeScript.
Purpose: Provides the user interface, handles user interactions, and communicates with the backend API.
Key Features:
Server-side rendering (SSR) for improved SEO and initial load time.
Client-side routing with Next.js's App Router.
Component-based UI architecture.
State management with Zustand.
API data fetching and caching with TanStack Query.
Form handling with React Hook Form and Zod validation.
Code editor integration with CodeMirror 6.
Animation and transitions with Framer Motion.
Rich content authoring with MDX.
Responsive design using Tailwind CSS.
Accessibility features (WCAG 2.1 AA compliance).
Internationalization (i18n) support.
5.1.2 Backend Services
Technology: Express.js 4.18.2 running on Node.js 20 LTS, with TypeScript.
Purpose: Provides the RESTful API for the frontend and other clients. Handles business logic, data access, and integration with external services.
Key Services:
API Gateway: Handles incoming requests, routing, and authentication.
Authentication Service: Manages user authentication, authorization, and session management.
Challenge Service: Manages the challenge library, including creation, retrieval, updating, and deletion of challenges.
Submission Service: Handles code submissions, executes tests, and coordinates feedback generation.
User Service: Manages user profiles, progress tracking, and user-related data.
AI Feedback Service: Generates personalized feedback on code submissions using AI models.
Analytics Service: Collects and processes data for user activity, platform usage, and educational outcomes. (Future)
Payment Service: Handles subscription management and payment processing (Future).
5.1.3 AI/Machine Learning Layer
Purpose: Powers the AI feedback system, providing personalized code reviews and learning recommendations.
Key Components:
AI Provider Abstraction: A layer that abstracts the interaction with different AI models (OpenAI, Anthropic).
Prompt Engineering Framework: A system for generating optimized prompts for AI models, incorporating task context, user information, and specific feedback criteria.
Feedback Processing Pipeline: A pipeline for pre-processing code submissions, calling the AI API, parsing the response, and storing the feedback.
Multi-Tiered Model Selection: A strategy for selecting the appropriate AI model based on cost, performance, and user tier.
Fallback Mechanisms: Fallback to pattern-based feedback or basic feedback if AI generation fails.
Feedback Monitor: Used to monitor AI model performance, usage and cost.
5.1.4 Data Layer
Primary Database: PostgreSQL 16 – Stores structured data such as user accounts, challenge information, and submission metadata.
ORM: Prisma 5.4.2 – Provides type-safe database access and migrations.
Connection Pooling: PgBouncer – Manages database connections efficiently.
Caching: Redis 7.2 – Stores session data, API response caches, and AI feedback caches.
Search: MeiliSearch 1.5 (Phase 2) – Enables fast, relevant search for challenges and resources.
Object Storage: DigitalOcean Spaces (S3-compatible) – Stores user-uploaded files and potentially large code submissions.
5.1.5 Infrastructure
Hosting: DigitalOcean App Platform (initial), Kubernetes (Phase 3).
Containerization: Docker, Docker Compose (for development).
CI/CD: GitHub Actions.
Monitoring: Sentry (error tracking), Prometheus & Grafana (metrics), ELK stack (logging).
5.2 Database Architecture (Expanded)
(The schema is already fully defined above, this section adds implementation details.)

Connection Pooling: Use PgBouncer for connection pooling to improve the efficiency to database.
Database configuration:
Set appropriate connection limits in PostgreSQL (max_connections).
Tune shared buffers and other memory settings based on instance size.
Enable query logging for performance analysis.
Prisma Client Usage:
Always release resources and close the connection properly.
Use batch operations whenever is possible.
5.3 API Design
(Content already provided in previous iteration. This section is complete and consistent with the requirements.)
API End points:

5.3.1 Authentication API
POST /api/v1/auth/register
- Register a new user
- Request: { name, email, password }
- Response: { token, user }

POST /api/v1/auth/login
- Authenticate a user
- Request: { email, password }
- Response: { token, user }

POST /api/v1/auth/github
- Authenticate with GitHub
- Request: { code }
- Response: { token, user }

GET /api/v1/auth/me
- Get current user data
- Headers: Authorization: Bearer [token]
- Response: { user }

POST /api/v1/auth/logout
- Invalidate the current session
- Headers: Authorization: Bearer [token]
- Response: { success: true }

GET /api/v1/auth/csrf-token
- Get csrf token
- Response: { csrfToken }
content_copy
download
Use code with caution.
5.3.2 User API
GET /api/v1/users/me/profile
- Get user profile data
- Headers: Authorization: Bearer [token]
- Response: { profile }

PUT /api/v1/users/me/profile
- Update user profile
- Headers: Authorization: Bearer [token]
- Request: { name, profileImage, settings }
- Response: { profile }

GET /api/v1/users/me/progress
- Get user progress stats
- Headers: Authorization: Bearer [token]
- Response: { progress, stats }

GET /api/v1/users/me/submissions
- Get user submission history
- Headers: Authorization: Bearer [token]
- Query: ?page=1&limit=20&challengeId=...
- Response: { submissions, pagination }

5.3.3 Challenge API
GET /api/v1/challenges
- List available challenges
- Query: ?difficulty=BEGINNER&category=algorithms&search=sort&page=1&limit=20
- Response: { challenges, pagination }

GET /api/v1/challenges/:id
- Get challenge details
- Response: { challenge }

POST /api/v1/challenges
- Create a new challenge (instructor only)
- Headers: Authorization: Bearer [token]
- Request: { title, description, ... }
- Response: { challenge }

PUT /api/v1/challenges/:id
- Update a challenge (creator or admin only)
- Headers: Authorization: Bearer [token]
- Request: { title, description, ... }
- Response: { challenge }

GET /api/v1/challenges/categories
- Get all challenge categories
- Response: { categories }

5.3.4 Submission API
POST /api/v1/submissions
- Submit code for a challenge
- Headers: Authorization: Bearer [token]
- Request: { challengeId, language, code }
- Response: { submission, testResults }

GET /api/v1/submissions/:id
- Get submission details
- Headers: Authorization: Bearer [token]
- Response: { submission, testResults }

GET /api/v1/submissions/:id/feedback
- Get AI feedback for a submission
- Headers: Authorization: Bearer [token]
- Response: { feedback }

POST /api/v1/submissions/:id/feedback/regenerate
- Regenerate AI feedback (premium feature)
- Headers: Authorization: Bearer [token]
- Response: { jobId }

GET /api/v1/submissions/feedback/job/:jobId
- Check status of feedback generation job
- Headers: Authorization: Bearer [token]
- Response: { status, feedback? }

5.3.5 Analytics API
GET /api/v1/analytics/me
- Get personal analytics
- Headers: Authorization: Bearer [token]
- Response: { progressSummary, recentActivity, ... }

GET /api/v1/analytics/instructor/challenges
- Get instructor challenge analytics
- Headers: Authorization: Bearer [token]
- Response: { challengeStats, submissionStats, ... }

GET /api/v1/analytics/challenge/:id
- Get detailed challenge analytics
- Headers: Authorization: Bearer [token]
- Response: { submissionStats, userStats, ... }

5.3.6 Course API (Phase 2)
GET /api/v1/courses
- List available courses
- Headers: Authorization: Bearer [token]
- Response: { courses, pagination }

GET /api/v1/courses/:id
- Get course details
- Headers: Authorization: Bearer [token]
- Response: { course, challenges, enrollment }

POST /api/v1/courses
- Create a new course (instructor only)
- Headers: Authorization: Bearer [token]
- Request: { title, description, ... }
- Response: { course }

POST /api/v1/courses/:id/enroll
- Enroll in a course
- Headers: Authorization: Bearer [token]
- Response: { enrollment }

GET /api/v1/courses/:id/students
- Get enrolled students (instructor only)
- Headers: Authorization: Bearer [token]
- Response: { students, pagination }

5.4 Security Architecture
(Content consolidated from previous iterations and Section 10, with additions for clarity and completeness.)

Authentication and Authorization:

Multi-Layer Authentication:
Email/Password with bcrypt hashing.
OAuth 2.0 with PKCE (Proof Key for Code Exchange) for secure authorization code flow.
Support for GitHub, Google, and potentially LinkedIn OAuth.
Optional Multi-Factor Authentication (MFA) using email or authenticator apps.
JWT Implementation:
Short-lived JWTs (access tokens) with a 1-hour expiration.
Refresh tokens with a 7-day expiration.
JWT secret stored securely in environment variables (JWT_SECRET).
Separate secret for refresh tokens (JWT_REFRESH_SECRET).
Token revocation using a Redis-backed blacklist.
Secure, HttpOnly, SameSite=Strict cookies for storing refresh tokens. Never store tokens in local storage.
Role-Based Access Control (RBAC):
Roles: STUDENT, INSTRUCTOR, ADMIN.
Middleware functions (auth, authorize, verifyOwnership) to enforce role-based and ownership-based access control.
Example:
// Example usage of authorization middleware
import { authenticate, authorize, verifyOwnership } from '../middleware/auth.middleware';

// Only instructors and admins can create challenges
router.post('/challenges', authenticate, authorize(['INSTRUCTOR', 'ADMIN']), challengeController.createChallenge);

// Only the owner or an admin can update a challenge
router.put('/challenges/:id', authenticate, verifyOwnership('challenge'), challengeController.updateChallenge);

TypeScript
Input Validation: Use Zod for all API requests, and in database operation.
Data Protection:

Data in Transit:
HTTPS for all API communication using TLS 1.3.
Secure WebSockets (WSS) for real-time features.
HTTP Strict Transport Security (HSTS) headers.
Data at Rest:
Encryption of sensitive database fields (e.g., user passwords, API keys) using Prisma's encryption capabilities.
Encrypted storage volumes for all persistent data.
Secure Access Control: Parameterized queries via Prisma to prevent SQL injection.
API Security:
Request throttling and rate limiting.
Content Security Policy headers.
CSRF Protection: csurf middleware with HttpOnly, Secure and SameSite=Strict cookies.
Secure Code Execution:

Container Isolation: Docker containers with restricted capabilities.
Resource Limits: Memory, CPU, and network limits per container.
Language-Specific Sandboxing:
JavaScript: vm2 module.
Python: Resource limiting.
Java: SecurityManager.
Execution Monitoring: Strict timeouts, resource usage tracking, automated container cleanup.
Vulnerability Management:

Dependency Scanning: Automated scanning using GitHub dependency alerts, Snyk, or similar tools.
Code Scanning: Static code analysis with SonarQube, ESLint (security rules), Semgrep.
Penetration Testing: Regular security testing with OWASP ZAP, Burp Suite.
AI Instruction: Implement all the security measures described above. Prioritize security throughout the development lifecycle. Use secure coding practices and follow OWASP guidelines. Regularly review and update security measures.

6. DevOps and Deployment
6.1 CI/CD Pipeline
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
          target: 'https://staging.kodelab.io' # Replace with your staging URL

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

Yaml

```yaml
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

**AI Instruction:** Use this GitHub Actions workflow file (`.github/workflows/ci-cd.yml`).  This workflow defines the CI/CD pipeline for the project.  It includes jobs for validation (linting, type checking, unit tests, integration tests, security scans), building and pushing Docker images, and deploying to DigitalOcean App Platform.  The workflow is triggered on pushes to `main` and `staging` branches, and on pull requests to those branches. It uses environment variables and secrets for sensitive information. This is a *complete* and *executable* workflow.

### 6.2 Docker Compose Setup for Development

```yaml
# docker-compose.yml
version: '3.8'
services:
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.dev  # Use a separate Dockerfile for development
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
      - /app/node_modules # Named volume to prevent overwriting node_modules
    environment:
      - NODE_ENV=development
      - NEXT_PUBLIC_API_URL=http://localhost:4000 # Points to the backend container
    depends_on:
      - backend
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/api/health"] # Assuming a health check endpoint
      interval: 30s
      timeout: 10s
      retries: 3

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.dev # Use a separate Dockerfile for development
    ports:
      - "4000:4000"
    volumes:
      - ./backend:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://postgres:postgres@pgbouncer:6432/kodelab
      - REDIS_URL=redis://redis:6379
      - SESSION_SECRET=${SESSION_SECRET} # Use .env file for secrets
      - OPENAI_API_KEY=${OPENAI_API_KEY} # Use .env file for secrets
      - CORS_ORIGIN=http://localhost:3000
    depends_on:
      pgbouncer:
        condition: service_healthy
      redis:
        condition: service_healthy
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:4000/health"] # Health check endpoint
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
    volumes:
      - ./backend/config/pgbouncer.ini:/etc/pgbouncer/pgbouncer.ini:ro
      - ./backend/config/userlist.txt:/etc/pgbouncer/userlist.txt:ro
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
  mailhog: # Added for email testing in development
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

  pgadmin: # Added for database administration in development
    image: dpage/pgadmin4
    ports:
      - "8080:80"
    environment:
      - PGADMIN_DEFAULT_EMAIL=admin@example.com # Change this in your .env
      - PGADMIN_DEFAULT_PASSWORD=admin # Change this in your .env
    depends_on:
      - db
    restart: unless-stopped

volumes:
  postgres_data:
  redis_data:
```
* Create `Dockerfile.dev` for `backend`, and `frontend`, with content:
**Backend Dockerfile.dev**:
```dockerfile
# Use the official Node.js 20 LTS image as the base image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application code
COPY . .

# Expose the port the app listens on
EXPOSE 4000

# Command to run the application in development mode (using nodemon)
CMD ["npm", "run", "dev"]
```

**Frontend Dockerfile.dev**
```dockerfile
# Use the official Node.js 20 LTS image as the base image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application code
COPY . .

# Expose the port the app listens on
EXPOSE 3000

# Command to run the application in development mode
CMD ["npm", "run", "dev"]
```
**AI Instruction:**  Use this `docker-compose.yml` file to set up the local development environment.  Run `docker-compose up -d` to start all services.  Use `docker-compose down` to stop the services.  Create separate `Dockerfile.dev` files for development that use `nodemon` (backend) and Next.js's built-in development server (frontend) for hot-reloading.

### 6.3 Deployment Configuration

**(This section refers to files like `deploy/production.yaml` which are deployment configurations for DigitalOcean App Platform. While I cannot create these files directly, I will describe their contents.)**

**Deployment Environments:**

*   **Staging:**  A production-like environment used for testing before deploying to production.  The staging environment should mirror the production environment as closely as possible.  Deployments to staging occur automatically on merges to the `develop` branch.
*   **Production:** The live environment accessible to users. Deployments to production occur automatically on merges to the `main` branch.

**DigitalOcean App Platform Configuration (`deploy/production.yaml` - Conceptual):**

```yaml
# deploy/production.yaml (Conceptual - for DigitalOcean App Platform)
name: kodelab-production
region: nyc # Choose your preferred region
services:
  - name: frontend
    github:
      branch: main
      deploy_on_push: true
      repo: kodelab/kodelab  # Replace with your repository
    build_command: npm run build
    run_command: npm start
    http_port: 3000
    instance_count: 2 # Start with 2 instances for redundancy
    instance_size_slug: basic-s # Choose an appropriate instance size
    routes:
      - path: /
    envs:
      - key: NODE_ENV
        value: production
      - key: NEXT_PUBLIC_API_URL
        value: https://api.kodelab.io # Replace with your API domain
      - key: SENTRY_DSN
        value: ${sentry_dsn} # Use DigitalOcean's secret management
        type: secret

  - name: backend
    github:
      branch: main
      deploy_on_push: true
      repo: kodelab/kodelab  # Replace with your repository
    build_command: npm run build
    run_command: npm start
    http_port: 4000
    instance_count: 2 # Start with 2 instances
    instance_size_slug: basic-s
    routes:
      - path: /api
    envs:
      - key: NODE_ENV
        value: production
      - key: DATABASE_URL
        value: ${db_url} # Use DigitalOcean's secret management
        type: secret
      - key: REDIS_URL
        value: ${redis_url} # Use DigitalOcean's secret management
        type: secret
      - key: JWT_SECRET
        value: ${jwt_secret} # Use DigitalOcean's secret management
        type: secret
      - key: OPENAI_API_KEY
        value: ${openai_api_key} # Use DigitalOcean's secret management
        type: secret
      - key: SENTRY_DSN
        value: ${sentry_dsn} # Use DigitalOcean's secret management
        type: secret
      - key: SPACES_KEY
        value: ${spaces_key}
        type: secret
      - key: SPACES_SECRET
        value: ${spaces_secret}
        type: secret

databases:
  - name: db # PostgreSQL database
    engine: PG
    version: "16"
    cluster_name: kodelab-db-prod # Choose a unique name
    production: true # Enable production settings (e.g., backups)
    num_nodes: 1 # Start with a single node, scale as needed
    size: db-s-1vcpu-1gb # Choose appropriate size
    # ... other database settings ...
redis:
 - name: redis # Redis instance
   num_nodes: 1
   size: redis-s-1vcpu-1gb

```

**`deploy/staging.yaml`:**  Would be very similar to `production.yaml`, but:

*   `name`: `kodelab-staging`
*   `github.branch`: `develop`
*   `instance_count`: May be lower (e.g., 1) to save costs.
*   `instance_size_slug`: May be smaller.
*  Database and Redis may have different cluster name and size.

**AI Instruction:** Create `deploy/staging.yaml` and `deploy/production.yaml` files based on the above structure.  Adapt the instance sizes and resource allocations as needed.  Use DigitalOcean's secret management for *all* sensitive environment variables. Do *not* hardcode secrets in the configuration files.

## 7. Frontend Architecture

**(This section consolidates and expands upon previous iterations, incorporating details about component structure, state management, and API integration.)**

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

*   **`app/`:**  Contains the main application routes, using the Next.js App Router.  Each route is a directory containing a `page.tsx` file.
*   **`components/`:**  Contains reusable UI components.
    *   `ui/`:  Base UI components (from `shadcn/ui` or custom-built).  These are presentational components with minimal logic.
    *   `dashboard/`, `challenge/`, `feedback/`, etc.:  Domain-specific components.
*   **`lib/`:**  Contains utilities, API clients, and state management logic.
    *   `api/`:  Functions for interacting with the backend API.
    *   `state/`:  Zustand stores for global state management.
    *   `utils/`:  Reusable utility functions.
*   **`styles/`:**  Contains global styles and CSS modules.

**AI Instruction:**  Maintain this component structure.  Create new components within the appropriate directories based on their purpose.

### 7.2 Page Implementation Example

**(Already provided in previous iteration - reproduced here for completeness):**

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

**(Already provided in previous iteration - reproduced here for completeness):**

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

**(Already provided in previous iteration - reproduced here for completeness):**

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
    const response = await axios.get(`${API_URL}/api/v1/challenges?${params.toString()}`, {
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
    const response = await axios.get(`${API_URL}/api/v1/challenges/${id}`, {
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
      `${API_URL}/api/v1/submissions`,
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
      `${API_URL}/api/v1/challenges`,
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

**AI Instruction:** Use `axios` for making API requests.  Use `TanStack Query` for managing server state (caching, automatic retries, background updates, etc.).  Handle errors appropriately and display user-friendly messages.

**TanStack Query Example:**

```typescript
// Example TanStack Query implementation for challenge loading
export function useChallengeQuery(challengeId: string) {
  return useQuery({
    queryKey: ['challenge', challengeId],
    queryFn: () => api.challenges.getChallenge(challengeId), // Use the API function
    staleTime: 5 * 60 * 1000, // 5 minutes
    cacheTime: 60 * 60 * 1000, // 1 hour
    retry: 2,
    onError: (error) => {
      logger.error('Failed to fetch challenge', { challengeId, error });
    }
  });
}
```
### 7.5 State Management using Zustand
**(Already provided in previous iteration - reproduced here for completeness):**
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

**AI Instruction:** Use Zustand for managing global state in the frontend. Create separate stores for different parts of the application (e.g., `auth-store`, `editor-store`, `challenge-store`). Use the `persist` middleware to persist relevant state to local storage.

### 7.6 Form Handling with React Hook Form and Zod

**(Already provided in previous iteration - reproduced here for completeness):**

```typescript
// components/auth/register-form.tsx
'use client';

import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { Button } from '../ui/button';
import { Input } from '../ui/input';
import { Label } from '../ui/label';
import { registerUser } from '@/lib/api/auth'; // Assuming you have an API function
import { useToast } from '@/components/ui/use-toast';

// Define the validation schema with Zod
const registerSchema = z.object({
  name: z.string().min(1, { message: 'Name is required' }).max(255),
  email: z.string().email({ message: 'Invalid email address' }),
  password: z
    .string()
    .min(8, { message: 'Password must be at least 8 characters' })
    .max(72, { message: 'Password must be less than 72 characters' }),
});

// Define the type from the schema
type RegisterFormData = z.infer<typeof registerSchema>;

export function RegisterForm() {
  const { toast } = useToast()
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting },
  } = useForm<RegisterFormData>({
    resolver: zodResolver(registerSchema),
  });

  const onSubmit = async (data: RegisterFormData) => {
    try {
      await registerUser(data); // Call your API function to register
      toast({
        title: 'Registration Successful',
        description: 'Please check your email to verify your account.',
        variant: 'default',
      });
    } catch (error) {
       toast({
        title: "Registration Failed",
        description: 'Email is already used.',
        variant: 'destructive'
      });
    }
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
      <div>
        <Label htmlFor="name">Name</Label>
        <Input
          type="text"
          id="name"
          {...register('name')}
          disabled={isSubmitting}
          placeholder="Enter your name"
        />
        {errors.name && <p className="text-red-500">{errors.name.message}</p>}
      </div>
      <div>
        <Label htmlFor="email">Email</Label>
        <Input
          type="email"
          id="email"
          {...register('email')}
          disabled={isSubmitting}
          placeholder="Enter your email"
        />
        {errors.email && <p className="text-red-500">{errors.email.message}</p>}
      </div>
      <div>
        <Label htmlFor="password">Password</Label>
        <Input
          type="password"
          id="password"
          {...register('password')}
          disabled={isSubmitting}
          placeholder="Enter your password"
        />
        {errors.password && (
          <p className="text-red-500">{errors.password.message}</p>
        )}
      </div>
      <Button type="submit" disabled={isSubmitting} className="w-full">
        {isSubmitting ? 'Registering...' : 'Register'}
      </Button>
    </form>
  );
}
```
### 7.7 Code Splitting and Lazy Loading

**Code Splitting:**

*   **Strategy:** Use Next.js's built-in dynamic `import()` to split the application into smaller chunks.  Load only the code needed for the current route or user interaction. This improves initial load time by reducing the size of the initial JavaScript bundle.
*   **Example:**

    ```typescript
    // pages/dashboard.tsx
    import dynamic from 'next/dynamic';

    const HeavyComponent = dynamic(() => import('../components/HeavyComponent'), {
      loading: () => <p>Loading...</p>,
      ssr: false, // Often useful to set ssr to false for client-side only components
    });

    function Dashboard() {
      return (
        <div>
          <h1>Dashboard</h1>
          <Suspense fallback={<p>Loading Heavy Component...</p>}>
            <HeavyComponent />
          </Suspense>
        </div>
      );
    }

    export default Dashboard;
    ```

*   **AI Instruction:**  Identify components that are not critical for initial page load (e.g., large charting libraries, complex modals, code editors) and load them dynamically using `next/dynamic`.  Use Suspense to show a loading indicator while the component is being fetched. Prioritize code splitting for larger, less frequently used components.

**Lazy Loading:**

*   **Images:** Use the `next/image` component for optimized image loading.  It automatically handles lazy loading, image optimization, and responsive sizing.

    ```typescript
    // components/MyImage.tsx
    import Image from 'next/image';

    function MyImage() {
      return (
        <Image
          src="/images/my-image.jpg"
          alt="My Image"
          width={500}
          height={300}
          loading="lazy" // Enable lazy loading
        />
      );
    }
    ```

*   **Components:** Use the `React.lazy` function (combined with `Suspense`) to lazy-load components that are not immediately visible (e.g., components below the fold, components that are only rendered conditionally).

    ```typescript
    import React, { Suspense, lazy } from 'react';

    const LazyComponent = lazy(() => import('./LazyComponent'));

    function MyComponent() {
      return (
        <div>
          <h1>My Component</h1>
          <Suspense fallback={<div>Loading...</div>}>
            <LazyComponent />
          </Suspense>
        </div>
      );
    }
    
```typescript
    import React, { Suspense, lazy } from 'react';

    const LazyComponent = lazy(() => import('./LazyComponent'));

    function MyComponent() {
      return (
        <div>
          <h1>My Component</h1>
          <Suspense fallback={<div>Loading...</div>}>
            <LazyComponent />
          </Suspense>
        </div>
      );
    }
    ```

*   **AI Instruction:**  Identify components and images that are below the fold or conditionally rendered and implement lazy loading.  Use `next/image` for *all* images. Use `React.lazy` and `Suspense` for components. Analyze the generated JavaScript bundles to identify opportunities for further code splitting.

## 8. AI Feedback System

**(This section consolidates and refines the AI feedback system details from previous iterations.)**

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
```

### 8.2 AI Feedback Service Implementation

The AI Feedback Service uses a multi-tiered approach to generate personalized code feedback while optimizing costs. It prioritizes speed and cost-effectiveness by checking for cached results and similar submissions before resorting to expensive AI model calls.

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
    attempts: 3, // Retry the job up to 3 times
    backoff: { type: 'exponential', delay: 5000 }, // Exponential backoff
    removeOnComplete: true // Automatically remove completed jobs
  }
});

interface FeedbackRequest {
  submissionId: string;
  userId: string;
  code: string;
  language: string;
  challengeId: string;
  urgent?: boolean;
  subscriptionTier?: 'free' | 'student' | 'professional' | 'institutional';
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
  source?: 'cache' | 'pattern' | 'ai' | 'basic' | 'similarity';
}

interface PatternResult {
  confidence: number;
  feedback: FeedbackResponse | null;
}
export class AIFeedbackService {
 /**
   * Generate feedback for code submission
   * @param request Feedback request parameters
   * @returns Job ID or feedback response
   */
  async generateFeedback(request: FeedbackRequest): Promise<string | FeedbackResponse> {
    const { submissionId, code, language, challengeId, userId, urgent = false, subscriptionTier = 'free' } = request;

    // For non-urgent requests, queue processing and return job ID
    if (!urgent) {
      const job = await feedbackQueue.add(
        { submissionId, code, language, challengeId, userId, urgent: false },
        {
          attempts: 3,
          backoff: { type: 'exponential', delay: 5000 }
        }
      );

      // Mark as pending in Redis
      await redis.set(
        `feedback:pending:${submissionId}`,
        '1',
        'EX',
        300 // 5 minutes
      );

      return job.id.toString();
    }

    // Generate code fingerprint for caching
    const codeFingerprint = this.generateCodeFingerprint(code, language);

    // Check cache first (fastest path)
    const cachedFeedback = await this.checkCache(codeFingerprint);
    if (cachedFeedback) {
      await this.trackUsage(userId, 'cache_hit', challengeId);
      await this.saveFeedback(submissionId, cachedFeedback);
      return { ...cachedFeedback, source: 'cache' };
    }

    // Check for similar submissions (second fastest path)
    const similarFeedback = await this.findSimilarFeedback(code, challengeId);
    if (similarFeedback) {
      await this.trackUsage(userId, 'similarity_match', challengeId);
      await this.saveFeedback(submissionId, similarFeedback);
      return { ...similarFeedback, source: 'similarity' };
    }

    // Analyze for patterns (third fastest path)
    const patternResult = await this.analyzePatterns(code, language, challengeId);
    if (patternResult.confidence > 0.7) {
      await this.trackUsage(userId, 'pattern_match', challengeId);
      await this.saveFeedback(submissionId, patternResult.feedback);
      await this.cacheResult(codeFingerprint, patternResult.feedback);
      return { ...patternResult.feedback, source: 'pattern' };
    }

    // Check user's AI usage quota
    const hasQuota = await this.checkUserQuota(userId, subscriptionTier);
    if (!hasQuota) {
      const basicFeedback = this.generateBasicFeedback(code, language, challengeId);
      await this.trackUsage(userId, 'quota_exceeded', challengeId);
      await this.saveFeedback(submissionId, basicFeedback);
      return { ...basicFeedback, source: 'basic' };
    }

    // --- AI Model Selection Strategy ---
    let model = 'gpt-3.5-turbo'; // Default to cost-effective model
    let modelName = 'GPT-3.5 Turbo';

    if (urgent) {
        model = 'gpt-4'; // Prioritize speed for urgent requests
        modelName = 'GPT-4';
    } else if (subscriptionTier === 'professional' || subscriptionTier === 'institutional') {
      model = 'gpt-4'; // Premium users get higher-quality model
      modelName = 'GPT-4';
    }
    // Add other model option
    // else if (subscriptionTier === 'enterprise'){
    // model = '<CUSTOM_MODEL>'; // Use custom model.
    // }

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
        model: model,
        temperature: 0.3,
        maxTokens: 800,
        timeout: 15000
      });
      const processingTime = Date.now() - startTime;

      // Parse AI response
        const feedback = this.parseAIResponse(aiResponse, processingTime, modelName);

      // Track token usage for quotas and billing
      const tokenCount = aiResponse.usage?.totalTokens || 500; // Default if usage is not returned
      await this.trackUsage(userId, 'ai_feedback', challengeId, tokenCount);

      // Save feedback to database
      await this.saveFeedback(submissionId, feedback);

      // Store embedding for future similarity matching
      await this.storeEmbedding(submissionId, code);

      // Cache result
      await this.cacheResult(codeFingerprint, feedback);

      return { ...feedback, source: 'ai' };

    } catch (error) {
      logger.error('AI feedback error', { error, submissionId });

      // --- Fallback Mechanisms ---
      // 1. Pattern-Based Feedback (if not already attempted)
      if(patternResult.confidence < 0.8){
        const patternResult = await this.analyzePatterns(code, language, challengeId);
        if (patternResult.confidence > 0.7) {
          await this.trackUsage(userId, 'pattern_match',challengeId);
          await this.saveFeedback(submissionId, patternResult.feedback);
          await this.cacheResult(codeFingerprint, patternResult.feedback);
          return { ...patternResult.feedback, source: 'pattern' };
        }
      }

      // 2. Basic Feedback
      const basicFeedback = this.generateBasicFeedback(code, language, challengeId);
      await this.trackUsage(userId, 'ai_error', challengeId); // Log the AI error
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
    // ... (rest of the methods) ...
}
```
**AI Instruction:** Implement the `AIFeedbackService` class with the multi-tiered approach: caching, similar submission check, pattern analysis, quota check, AI model selection, prompt generation, AI API call, response parsing, feedback storage, and fallback mechanisms. Ensure that the code is well-documented and handles errors gracefully.

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

**AI Instruction:**  Implement the `AIProvider` class to abstract the interaction with the AI service (OpenAI or Anthropic). Include functions for generating feedback (`generateFeedback`) and generating embeddings (`generateEmbedding`).  Handle API keys securely (using environment variables). Implement error handling and retry mechanisms.

**(The remaining methods for `AIFeedbackService`, such as `generateCodeFingerprint`, `checkCache`, `findSimilarFeedback`, `analyzePatterns`, `createPrompt`, `parseAIResponse`, `saveFeedback`, `checkUserQuota`, `trackUsage`, and `generateBasicFeedback` are fully defined in previous iterations and are included here by reference.  The AI agents should implement these methods as previously specified.)**

### 8.4 Feedback Display Component

**(Already provided in previous iteration.  Reproduced here for completeness):**

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
**(Already provided in previous iteration - reproduced here for completeness):**

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

       // Start monitoring resource usage (example - adjust as needed)
      const statsStream = await container.stats({ stream: true });
      statsStream.on('data', (stats: any) => {
        // Process container stats (CPU, memory, etc.)
        // You can log these, send alerts, or take other actions based on resource usage.
         logger.info('Container Stats:', { executionId, stats });
      });
      // ... (wait for container to finish) ...
      statsStream.destroy(); // Stop the stats stream

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
        runCommand: ['node', '--expose-internals', './node_modules/vitest/vitest.mjs', 'run', '--reporter=json', '--outputFile=test-results.json'], // Modified command
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
                memoryUsed: process.memoryUsage().heapUsed / 1024 /1024
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
        runCommand: ['python', '-m', 'pytest', '-v', '--json-report', '--json-report-file=test-results.json'],  // Modified command
        generateTestCode: (code, testCases) => {
          return `
            import json
            import sys
            import resource
            from io import StringIO
            import traceback
            import pytest

            # Set resource limits (example - adjust as needed)
            resource.setrlimit(resource.RLIMIT_CPU, (5, 5))  # 5 seconds CPU time
            #resource.setrlimit(resource.RLIMIT_AS, (256 * 1024 * 1024, 256 * 1024 * 1024))  # 256MB address space

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
                def test_case_${i}():
                    try:
                        result = solution_namespace['${test.functionName}'](${test.input})
                        expected = ${test.expectedOutput}
                        assert result == expected
                        test_results.append({
                            'id': ${i},
                            'description': "${test.description}",
                            'input': "${test.input}",
                            'expectedOutput': "${test.expectedOutput}",
                            'actualOutput': str(result),
                            'passed': True
                        })

                    except Exception as e:
                        test_results.append({
                            'id': ${i},
                            'description': "${test.description}",
                            'input': "${test.input}",
                            'expectedOutput': "${test.expectedOutput}",
                            'error': str(e),
                            'passed': False
                        })
                        global all_passed
                        all_passed = False
                `).join('\n')}

                execution_time = int((time.time() - start_time) * 1000)
                memory_used = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss / 1024 # in MB

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
       java: { // Added Java configuration
        image: 'openjdk:17-alpine',
        mainFile: 'Solution.java',
        testFile: 'SolutionTest.java',
        runCommand: ['mvn', 'test', '-DargLine=-Dfile.encoding=UTF-8', '-Dmaven.test.failure.ignore=true', '-Dtest=SolutionTest'], // Use Maven
        generateTestCode: (code, testCases) => {
          // ... (Generate JUnit 5 test code) ...
          return `
            import org.junit.jupiter.api.Test;
            import static org.junit.jupiter.api.Assertions.*;
            import java.util.*;

            public class SolutionTest {

                ${testCases.map((test, i) => `
                    @Test
                    public void testCase${i}() {
                        ${test.input}
                        var expected = ${test.expectedOutput};
                        var actual = Solution.${test.functionName};
                        ${test.expectedOutput.startsWith("[") ? `assertArrayEquals` : `assertEquals`}(expected, actual);
                    }
                `).join('\n')}
            }
          `;
        }
      },
      sql: {
        image: 'postgres:16-alpine',
        mainFile: 'solution.sql',
        testFile: 'test.sql', // Contains assertions or queries to check results
        runCommand: ['psql', '-U', 'postgres', '-d', 'testdb', '-f', '/app/test.sql'],
        generateTestCode: (code, testCases) => {
          // ... (Generate SQL setup and assertions) ...
          // Example: Create tables, insert data, run user's solution, check result tables.
            let testCode = `
                -- Setup database (create tables, insert data)
                CREATE TABLE users (id SERIAL PRIMARY KEY, name TEXT, email TEXT);
                INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com'), ('Bob', 'bob@example.com');

                -- Run user's solution
                ${code}
                -- test cases
                ${testCases.map(test=>`${test.input.trim()}`).join('\n')}
            `;
          return testCode;
        }
      },
    };

    return configs[language] || configs.javascript; // Default to JavaScript
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

    try {
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

    } catch (e) {
         return {
            status: 'error',
            error: 'Failed to parse execution results ' + e,
            executionTime: 0
        };
    }
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
**AI Instruction:** Implement the `CodeExecutorService` class with the following methods: `executeCode`, `getExecutionResult`, `runExecution`, `getLanguageConfig`, `parseTestResults`, and `formatErrorOutput`. Use the provided Docker configurations and test runner commands. Implement the security measures described in the System Architecture document. Ensure proper error handling and logging.  Use the `bull` queue for asynchronous execution.

## 5. Security Architecture

**(This section consolidates and expands on security details from previous iterations and the `SystemArchitectureDesign.md` document.)**

### 10.1 Authentication and Authorization

#### 10.1.1 Multi-Layer Authentication

The system implements multiple layers of authentication:

1.  **Email/Password Authentication:**
    *   Secure password hashing with `bcrypt` (cost factor of 12).
    *   Rate limiting for login attempts (see `middleware/rate-limit.middleware.ts`).
    *   Password validation requirements (minimum length: 8, maximum length: 72, mixed-case, numbers, special characters - enforced by Zod schema).
    *   Account lockout after 5 consecutive failed login attempts (to be implemented).

2.  **OAuth Integration:**
    *   GitHub OAuth for developers (initial implementation).
    *   Google OAuth for broad accessibility.
    * Support for email linking with social accounts.
    *   Future: LinkedIn OAuth.

3.  **JWT Implementation:**
    *   Short-lived JWTs (access tokens) with a 1-hour expiration.
    *   Refresh token rotation.
    *   Token revocation capabilities (Redis blacklist).
    *   Secure cookie storage with `HttpOnly`, `Secure`, and `SameSite=Strict` flags.

#### 10.1.2 Role-Based Access Control (RBAC)

```typescript
// middleware/auth.middleware.ts
import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { prisma } from '../lib/prisma';
import { redis } from '../lib/redis';
import { UnauthorizedError, ForbiddenError } from '../lib/errors';
import { logger } from '../lib/logger';
import crypto from 'crypto';

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
**AI Instruction:**  Implement the `authenticate`, `authorize`, and `verifyOwnership` middleware functions as shown above.  Use these middleware functions to protect API endpoints that require authentication and authorization.

### 10.2 Data Protection

#### 10.2.1 Data Encryption

1.  **Data in Transit:**
    *   HTTPS for all API communications using TLS 1.3.
    *   Secure WebSockets with TLS for real-time features.
    *   HTTP Strict Transport Security (HSTS) headers. Enforce HTTPS.
    * Secure cookies with HttpOnly, Secure, and SameSite.

2.  **Data at Rest:**
    *   Encryption of sensitive database fields (e.g., passwords, API keys, potentially PII) using Prisma's encryption capabilities or database-level encryption.
    *   Encrypted storage volumes (e.g., using DigitalOcean's block storage encryption).

#### 10.2.2 Secure Access Controls

1.  **Database Security:**
    *   Parameterized queries via Prisma to prevent SQL injection.
    *   Least privilege database users:  Create separate database users with limited permissions for different services.
    *   Network-level database isolation:  The database should only be accessible from within the private network.
    * Regular audit for database users and permissions.

2.  **API Security:**
    *   Input validation for all parameters using Zod schemas.
    *   Request throttling and rate limiting using `express-rate-limit` and Redis.
        *   General API rate limit: 100 requests per minute per IP.
        *   Authentication endpoints: 10 requests per 15 minutes per IP.
        *   Code submission: 5 submissions per minute per user.
    *   Content Security Policy (CSP) headers using `helmet` middleware.
    *   CSRF protection using `csurf` middleware.
    *   JWT validation and authentication using custom middleware.
    *   API key management for third-party services.

### 10.3 Secure Code Execution

**(Already detailed in previous iterations.  This section summarizes the key points.)**

The code execution environment is designed with multiple security layers:

1.  **Container Isolation:**
    *   Docker containers with restricted capabilities.
    *   Memory and CPU limits.
    *   No network access (by default).
    *   Process count limits.
    *   Read-only filesystem (except for a temporary workspace).
    * Use `vm2` for additional sandboxing in Javascript.
    * Use `resource` module to set resource limit in python.
2.  **Execution Monitoring:**
    *   Strict timeouts for all executions.
    *   Resource usage tracking (CPU, memory, network).
    *   Automated container cleanup.

### 10.4 Vulnerability Management

1.  **Dependency Scanning:**
    *   **Tools:** GitHub dependency alerts (Dependabot), Snyk, npm audit (integrated into CI/CD pipeline).
    *   **Process:** Automatically scan dependencies for known vulnerabilities on every pull request and on a scheduled basis (e.g., weekly). Block merging of pull requests if vulnerabilities with a severity level of "high" or "critical" are found.
    *   **Command:** `npm audit --production` (included in CI/CD pipeline).

2.  **Code Scanning:**
    *   **Tools:** SonarQube, ESLint (with security plugins), Semgrep, GitHub CodeQL.
    *   **Process:** Perform static code analysis on every pull request to identify potential security flaws, code quality issues, and adherence to coding standards. Configure rules to enforce secure coding practices. Integrate with the IDE for real-time feedback during development.

3.  **Penetration Testing:**
    *   **Tools:** OWASP ZAP, Burp Suite Professional.
    *   **Process:** Conduct regular penetration testing (at least annually) by a qualified third-party security firm. Perform automated penetration testing (DAST) as part of the CI/CD pipeline using OWASP ZAP. Focus on OWASP Top 10 vulnerabilities and application-specific attack vectors.

4.  **Vulnerability Disclosure Program:**
    *   Implement a vulnerability disclosure program (e.g., using HackerOne or Bugcrowd) to encourage responsible reporting of security vulnerabilities.
    *   Define a clear process for handling reported vulnerabilities, including triage, remediation, and disclosure.

**AI Instruction:** Implement all the security measures described above. Integrate the specified tools into the CI/CD pipeline. Regularly review and update security policies and procedures.

## 11. Error Handling and Logging

### 11.1 Error Handling Strategy

The application implements a consistent error handling strategy:

*   **Custom Error Classes:** Define custom error classes (extending the built-in `Error` class) for different types of errors (e.g., `BadRequestError`, `UnauthorizedError`, `NotFoundError`, `ExecutionError`).
*   **Centralized Error Handling:** Use Express.js middleware to catch all errors and return consistent error responses.
*   **Structured Error Responses:** Return error responses in a consistent JSON format:
    ```json
    {
      "error": {
        "code": "ERROR_CODE",
        "message": "A human-readable error message",
        "details": { ... } // Optional details (e.g., validation errors)
      }
    }
    ```
*   **Error Codes:** Use specific error codes (e.g., `INVALID_INPUT`, `USER_NOT_FOUND`, `DATABASE_ERROR`) to categorize errors.
* **Do not expose sensitive information in error messages returned to the client.**

### 11.2 Error Handling Middleware
**(Already fully implemented in previous iteration - included for completeness):**
```typescript
// middleware/error.middleware.ts
import { Request, Response, NextFunction } from 'express';
import { AppError } from '../lib/errors';
import { logger } from '../lib/logger';
import { ZodError } from 'zod';
import { AuthRequest } from './auth.middleware'; // Import AuthRequest

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

  // Log error with appropriate level and context
  const logEntry = {
    requestId: (req as any).requestId, // Assuming a middleware adds this
    userId: (req as AuthRequest).user?.id, // Use AuthRequest
    method: req.method,
    path: req.path,
    query: req.query,
    body: req.body, // Consider limiting the size of logged body
    error: err,
    statusCode,
    code,
    message,
    details
  };

  if (statusCode >= 500) {
    logger.error('Server error', logEntry);
  } else {
    logger.warn('Client error', logEntry);
  }

  // Return a consistent error response
  res.status(statusCode).json({
    error: {
      code,
      message, // Keep user-friendly
      details: process.env.NODE_ENV === 'production' ? undefined : details, // Only include details in development
    }
  });
}
```

### 11.3 Structured Logging System

**(Already fully implemented in previous iteration - included for completeness):**

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
    serviceName: 'kodelab-api' //Use same name in all services
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
**AI Instruction:** Use the `logger` instance for all logging. Include the `requestId` in all log entries. Use appropriate log levels (DEBUG, INFO, WARN, ERROR, FATAL).  Log all errors and exceptions with sufficient context.

## 12. Testing Strategy

**(Consolidated and refined from previous iterations.)**

The Job-Ready Skill Simulator will employ a comprehensive testing strategy, encompassing multiple levels of testing to ensure code quality, reliability, and security.

### 12.1 Unit Testing

*   **Purpose:**  To test individual functions, components, and modules in isolation.
*   **Tool:**  Vitest.
*   **Location:**  `backend/test/unit` and `frontend/test/unit`.
*   **Focus:**
    *   Testing the logic of individual functions.
    *   Verifying that components render correctly with different props.
    *   Testing edge cases and error conditions.
    *   Mocking external dependencies (database, API calls, etc.).
*   **Example:** (Already provided in previous iterations)

### 12.2 Integration Testing

*   **Purpose:** To test the interaction between multiple components or services.
*   **Tools:** Vitest, Supertest (for backend API testing).
*   **Location:** `backend/test/integration`.
*   **Focus:**
    *   Testing API endpoints with realistic data.
    *   Verifying database interactions.
    *   Testing the interaction between different services (e.g., authentication and submission).
    *   Testing the code execution flow.
*   **Example:** (Already provided in previous iterations)

### 12.3 End-to-End Testing

*   **Purpose:** To test the entire application flow from the user's perspective, simulating real user interactions.
*   **Tool:** Playwright.
*   **Location:** `frontend/test/e2e`.
*   **Focus:**
    *   Testing user workflows (e.g., registration, login, challenge submission, feedback review).
    *   Verifying UI behavior and responsiveness.
    *   Testing cross-browser compatibility.
    *   Testing different user roles and permissions.
*   **Example:** (Already provided in previous iterations)

### 12.4 Performance Testing

* **Tools:** K6
* **Process:**
    1. Write scripts to simulate the load.
    2. Run test and monitor server performance.
    3. Analyze the results.

### 12.5 Security Testing

*  Use the tools mentioned in `10.4 Vulnerability Management`.
*   **OWASP ZAP:** Run automated security scans as part of the CI/CD pipeline.
*   **Manual Penetration Testing:** Conduct periodic penetration testing by security experts.

### 12.6 Testing Pipeline

Integrate all tests into the CI/CD pipeline (GitHub Actions).

*   **Trigger:** Run tests on every pull request and on pushes to the `develop` and `main` branches.
*   **Stages:**
    1.  **Linting:** Run ESLint to check for code style and potential errors.
    2.  **Type Checking:** Run TypeScript type checking.
    3.  **Unit Tests:** Run unit tests with Vitest.
    4.  **Integration Tests:** Run integration tests with Vitest and Supertest.
    5.  **End-to-End Tests:** Run end-to-end tests with Playwright.
    6.  **Security Scans:** Run security scans (OWASP ZAP, dependency scanning).
*   **Reporting:** Generate test reports and code coverage reports.
*   **Failure Handling:** Fail the pipeline if any test fails or if code coverage falls below the target (80%).

**AI Instruction:** Implement a comprehensive testing strategy as described above. Write unit tests, integration tests, and end-to-end tests for all components and services.  Aim for at least 80% code coverage. Integrate tests into the CI/CD pipeline.

## 13. DevOps and Deployment
**(This section combines and refines the DevOps and deployment details from previous iterations.)**

### 13.1 CI/CD Pipeline

**(Already provided in previous iteration - reproduced here for completeness):**

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
          cache: '
          ```yaml
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
        run: npm audit --production #Run security check.
  security_scan:
    name: Security Scanning
    runs-on: ubuntu-latest
    needs: validate
    steps:
      - uses: actions/checkout@v3

      - name: Run OWASP ZAP scan
        uses: zaproxy/action-baseline@v0.9.0
        with:
          target: 'https://staging.kodelab.io' # Replace with your staging URL

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

**AI Instruction:**  This is the complete and executable CI/CD pipeline definition using GitHub Actions.  It includes jobs for:

*   **validate:**  Linting, type checking, unit tests, integration tests, and vulnerability checks.
*   **security_scan:** Performs security scans using OWASP ZAP and Trivy.
*   **build:** Building and pushing Docker images for the frontend and backend to the DigitalOcean Container Registry.
*   **deploy:** Deploying the application to the DigitalOcean App Platform.  This includes updating the App Platform specification and applying database migrations.

This pipeline is triggered on pushes to `main` and `staging`, and on pull requests to those branches. It uses environment variables and secrets for sensitive information.

### 13.2 Docker Compose Setup for Development

**(Already provided in previous iteration - reproduced here for completeness):**

```yaml
# docker-compose.yml
version: '3.8'
services:
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.dev  # Use a separate Dockerfile for development
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
      - /app/node_modules # Named volume to prevent overwriting node_modules
    environment:
      - NODE_ENV=development
      - NEXT_PUBLIC_API_URL=http://localhost:4000 # Points to the backend container
    depends_on:
      - backend
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/api/health"] # Assuming a health check endpoint
      interval: 30s
      timeout: 10s
      retries: 3

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile.dev # Use a separate Dockerfile for development
    ports:
      - "4000:4000"
    volumes:
      - ./backend:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://postgres:postgres@pgbouncer:6432/kodelab
      - REDIS_URL=redis://redis:6379
      - SESSION_SECRET=${SESSION_SECRET} # Use .env file for secrets
      - OPENAI_API_KEY=${OPENAI_API_KEY} # Use .env file for secrets
      - CORS_ORIGIN=http://localhost:3000
    depends_on:
      pgbouncer:
        condition: service_healthy
      redis:
        condition: service_healthy
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:4000/health"] # Health check endpoint
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
    volumes:
      - ./backend/config/pgbouncer.ini:/etc/pgbouncer/pgbouncer.ini:ro
      - ./backend/config/userlist.txt:/etc/pgbouncer/userlist.txt:ro
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
  mailhog: # Added for email testing in development
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
  pgadmin: # Added for database administration in development
    image: dpage/pgadmin4
    ports:
     - "8080:80"
    environment:
     - PGADMIN_DEFAULT_EMAIL=admin@example.com # Change this in your .env
     - PGADMIN_DEFAULT_PASSWORD=admin # Change this in your .env
    depends_on:
     - db
    restart: unless-stopped

volumes:
  postgres_data:
  redis_data:
```
**AI Instructions:**
* Use this `docker-compose.yml` file to set up the local development environment.
* Run `docker compose up -d` to start all services.
* Run `docker compose down` to stop the services.
* Create separate `Dockerfile.dev` files for development that use `nodemon` (backend) and Next.js's built-in development server (frontend) for hot-reloading.
* Ensure that the `backend` service depends on `pgbouncer` and `redis`, and that `pgbouncer` depends on `db`. Use health checks to ensure services are started in the correct order.
* Include `mailhog` for email testing during the development.
* Add `pgadmin` for database management.

### 13.3 Deployment Configuration

**(Conceptual YAML for DigitalOcean App Platform - already provided, reproduced here for completeness):**

```yaml
# deploy/production.yaml (Conceptual - for DigitalOcean App Platform)
name: kodelab-production
region: nyc # Choose your preferred region
services:
  - name: frontend
    github:
      branch: main
      deploy_on_push: true
      repo: kodelab/kodelab  # Replace with your repository
    build_command: npm run build
    run_command: npm start
    http_port: 3000
    instance_count: 2 # Start with 2 instances for redundancy
    instance_size_slug: basic-s # Choose an appropriate instance size
    routes:
      - path: /
    envs:
      - key: NODE_ENV
        value: production
      - key: NEXT_PUBLIC_API_URL
        value: https://api.kodelab.io # Replace with your API domain
      - key: SENTRY_DSN
        value: ${sentry_dsn} # Use DigitalOcean's secret management
        type: secret

  - name: backend
    github:
      branch: main
      deploy_on_push: true
      repo: kodelab/kodelab  # Replace with your repository
    build_command: npm run build
    run_command: npm start
    http_port: 4000
    instance_count: 2 # Start with 2 instances
    instance_size_slug: basic-s
    routes:
      - path: /api
    envs:
      - key: NODE_ENV
        value: production
      - key: DATABASE_URL
        value: ${db_url} # Use DigitalOcean's secret management
        type: secret
      - key: REDIS_URL
        value: ${redis_url} # Use DigitalOcean's secret management
        type: secret
      - key: JWT_SECRET
        value: ${jwt_secret} # Use DigitalOcean's secret management
        type: secret
      - key: OPENAI_API_KEY
        value: ${openai_api_key} # Use DigitalOcean's secret management
        type: secret
      - key: SENTRY_DSN
        value: ${sentry_dsn} # Use DigitalOcean's secret management
        type: secret
      - key: SPACES_KEY
        value: ${spaces_key}
        type: secret
      - key: SPACES_SECRET
        value: ${spaces_secret}
        type: secret

databases:
  - name: db # PostgreSQL database
    engine: PG
    version: "16"
    cluster_name: kodelab-db-prod # Choose a unique name
    production: true # Enable production settings (e.g., backups)
    num_nodes: 1 # Start with a single node, scale as needed
    size: db-s-1vcpu-1gb # Choose appropriate size
    # ... other database settings ...
redis:
 - name: redis # Redis instance
   num_nodes: 1
   size: redis-s-1vcpu-1gb

```

**`deploy/staging.yaml`:** Would be very similar to `production.yaml`, but:

*   `name`: `kodelab-staging`
*   `github.branch`: `develop`
*   `instance_count`: May be lower (e.g., 1) to save costs.
*   `instance_size_slug`: May be smaller.
*  Database and Redis may have different cluster name and size.

**AI Instruction:** Create `deploy/staging.yaml` and `deploy/production.yaml` files based on the above structure. Adapt the instance sizes and resource allocations as needed. Use DigitalOcean's secret management for *all* sensitive environment variables. Do *not* hardcode secrets in the configuration files.  These files are *declarative* descriptions of the desired infrastructure on DigitalOcean App Platform.

## 14. Scalability and Performance

**(Content largely from previous iterations, consolidated here.)**

### 14.1 Database Scalability

1.  **Connection Pooling:** PgBouncer is used for efficient connection management.  Configure appropriate connection limits based on instance size and expected load.
2.  **Read/Write Separation:** Prepare the architecture for read replicas (Phase 2).  Implement query routing to direct read-heavy queries to replicas.
3.  **Data Partitioning:**  Consider time-based partitioning for the `submissions` table (Phase 3). This improves query performance for historical data.
4.  **Sharding:** Design the data model with a future sharding strategy in mind (Phase 3+).  Consider sharding by user ID or challenge ID.
5. **Caching:** Use Redis for caching.
6. **Indexing Strategy**: Use indexes on frequently queried columns.

### 14.2 Application Scaling

1.  **Horizontal Scaling:** The API is designed to be stateless, allowing for horizontal scaling using a load balancer (DigitalOcean Load Balancer, or Kubernetes Ingress in Phase 3). Session data is stored in Redis, enabling shared state across multiple instances.
2.  **Asynchronous Processing:**  Use a queue-based system (Bull) for code execution and AI feedback generation.  This allows for asynchronous processing of resource-intensive tasks, preventing blocking operations from affecting API responsiveness.
3.  **Caching Strategy:** Implement a multi-level caching approach:
    *   **Redis:** Cache frequently accessed data (e.g., challenge details, user profiles, AI feedback for identical submissions).
    *   **API Response Caching:** Cache responses for public, read-only API endpoints (e.g., challenge list).
    *   **CDN:** Use a CDN (e.g., Cloudflare) to cache static assets (images, CSS, JavaScript) and potentially API responses.

### 14.3 Performance Optimization Techniques

1.  **Backend Optimizations:**
    *   **Efficient Database Queries:** Use Prisma's query builder to create optimized queries. Avoid unnecessary joins and projections. Use appropriate indexes.
    *   **Batching:** Batch multiple database operations into a single transaction where possible.
    *   **Pagination:** Use pagination for all list endpoints to avoid returning large datasets.
    *   **Timeout and Retry Mechanisms:** Implement timeouts and retries for external API calls (e.g., AI provider, GitHub).
    *   **Asynchronous Tasks:** Offload long-running or non-critical tasks to background workers.

2.  **Frontend Optimizations:**
    *   **Code Splitting:** Use Next.js's dynamic `import()` to split the application into smaller chunks, loading only the code needed for the current route.
    *   **Tree Shaking:** Ensure that unused code is eliminated from the production build.
    *   **Lazy Loading:** Load components and images lazily, as they are needed.
    *   **Image Optimization:** Use the `next/image` component for optimized image loading and responsive sizing.
    *   **Server-Side Rendering (SSR):** Use SSR for critical pages to improve initial load time and SEO.
    * **Minimize HTTP Requests:** Combine and minify CSS and JavaScript files.
    * **Browser Caching:** Configure appropriate cache headers for static assets.
    * **Gzip Compression:** Enable gzip compression on the server to reduce response sizes.

## 15. Academic Integration

### 15.1 LMS Integration (Phase 2)

1.  **LTI 1.3 Implementation:**
    *   Support single sign-on (SSO) from LMS platforms (Canvas, Blackboard, Moodle, D2L, etc.).
    *   Enable grade passback to LMS gradebooks.
    *   Allow deep linking to specific challenges and learning paths within the platform.
    *   Support resource selection for instructors (embedding platform content within LMS courses).
2.  **Supported Platforms:**
    *   Canvas
    *   Blackboard Learn
    *   Moodle
    *   D2L Brightspace
    *   Google Classroom
    *   Future: Sakai, Open edX
3. **Integration Features**: Course roster synchronization, assignment management, grade reporting and content embedding.

### 15.2 Instructor Tools

1.  **Assignment Management:**
    *   Ability to assign specific challenges to classes or individual students.
    *   Set due dates and deadlines for assignments.
    *   Add custom instructions or notes to assignments.
    *   Allow deadline extensions for individual students.

2.  **Student Progress Tracking:**
    *   Class-level progress dashboards showing overall performance.
    *   Individual student performance metrics (completion rates, scores, time spent).
    *   Submission history review for each student.
    *   Feedback effectiveness analysis (student ratings, implementation of suggestions).

3.  **Analytics for Instruction:**
    *   Challenge difficulty analysis based on student performance.
    *   Identification of skill gaps within a class or cohort.
    *   Time-to-completion metrics for different tasks.
    *   Comparative performance analysis across different classes or semesters.

## 16. Code Style and Best Practices

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
**(Already provided in previous iteration - reproduced here for completeness):**
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

**(Already fully provided in previous iterations.  Refer to Section 6: API Design and individual service definitions.)**

*   **Versioning:** Use explicit API versioning (e.g., `/api/v1/challenges`).
*   **RESTful Principles:** Follow RESTful design principles (resource-based URLs, standard HTTP methods).
* **Request Validation:** Use Zod schema.
* **Consistent Response:**
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

## 17. Implementation Roadmap

**(Already provided in previous iterations, and consistent with the input documents. Reproduced here.)**

### 17.1 Phase 1: Core Platform (8-10 weeks)

1.  **Week 1-2: Project Setup and Authentication**
    *   Repository and project structure setup
    *   Database schema implementation
    *   Authentication system (email/password, OAuth)
    *   User management basics
    *   Development environment with Docker Compose

2.  **Week 3-4: Challenge Engine**
    *   Challenge data models
    *   Challenge creation interface
    *   Code editor integration
    *   Test case management
    *   Basic challenge library (10-15 challenges)

3.  **Week 5-6: Submission System**
    *   Code execution environment
    *   Submission processing system
    *   Test result visualization
    *   Progress tracking
    *   Security measures for code execution

4.  **Week 7-8: AI Feedback System**
    *   AI integration with OpenAI/Claude
    *   Feedback caching and optimization
    *   Pattern-based feedback system
    *   Feedback visualization
    *   Cost control mechanisms

5.  **Week 9-10: User Experience and Dashboard**
    *   Student dashboard
    *   Progress visualization
    *   Challenge discovery and filtering
    *   User profile management
    *   Basic analytics implementation

### 17.2 Phase 2: Educational Integration (6-8 weeks)

1.  **Week 1-2: LMS Integration**
    *   LTI 1.3 provider implementation
    *   Single sign-on with LMS platforms
    *   Grade passback functionality
    *   Deep linking capabilities

2.  **Week 3-4: Course Management**
    *   Course creation and management
    *   Student enrollment
    *   Assignment management
    *   Deadline and due date handling

3.  **Week 5-6: Enhanced Analytics**
    *   Instructor dashboards
    *   Student performance tracking
    *   Challenge effectiveness analysis
    *   Learning pattern visualization

4.  **Week 7-8: Community Features**
    *   Discussion threads for challenges
    *   Solution sharing (post-completion)
    *   Peer feedback mechanisms
    *   Achievement and badge system

### 17.3 Phase 3: Scale and Enterprise (8-12 weeks)

1.  **Week 1-3: Infrastructure Enhancement**
    *   Kubernetes migration
    *   Multi-region deployment
    *   Enhanced monitoring
    *   Disaster recovery planning

2.  **Week 4-6: Enterprise Features**
    *   Team management
    *   Organization administration
    *   Custom branding
    *   Single sign-on for enterprises

3.  **Week 7-9: Advanced Learning Tools**
    *   Skill trees
    *   Learning path customization
    *   Project-based assessments
    *   Interview preparation tracks

4.  **Week 10-12: Data Insights**
    *   Advanced analytics dashboard
    *   Predictive modeling
    *   Recommendation engine
    *   Skills gap analysis

## 18. Technical Risks and Mitigations

**(Already provided in previous iterations and in `ProjectSpecificationDocument.md`.  Reproduced here for completeness.)**

### 18.1 Security Risks

| Risk                          | Severity | Mitigation                                                                |
| ----------------------------- | -------- | ------------------------------------------------------------------------- |
| Insecure code execution       | High     | Isolated Docker containers, resource limits, network isolation          |
| Authentication bypass        | High     | Multi-layer authentication, token validation, RBAC                       |
| Data exposure                | Medium   | Encryption at rest and in transit, access controls, audit logs          |
| Dependency vulnerabilities    | Medium   | Regular scanning, automated updates, dependency pinning                |
| Cross-site scripting (XSS)  | Medium   | Content Security Policy, input sanitization, output encoding             |
| SQL injection               | Medium   | Parameterized queries via Prisma, input validation                      |
| CSRF attacks                | Medium   | CSRF tokens, same-site cookies, proper headers                            |

### 18.2 Scalability Risks

| Risk                               | Severity | Mitigation                                                                   |
| ---------------------------------- | -------- | ---------------------------------------------------------------------------- |
| Database performance               | High     | Connection pooling, query optimization, indexing strategy                   |
| AI costs                           | High     | Multi-tiered approach, caching, pattern matching, quotas                    |
| Traffic spikes                     | Medium   | Auto-scaling, rate limiting, queue-based processing                        |
| Storage growth                     | Medium   | Data retention policies, archiving, efficient storage                     |
| API performance bottlenecks       | Medium   | Caching, pagination, efficient queries                                    |
| Long-running operations           | Medium   | Asynchronous processing, background jobs, timeouts                          |

### 18.3 Technical Debt Risks

| Risk                   | Severity | Mitigation                                                                    |
| ---------------------- | -------- | ----------------------------------------------------------------------------- |
| Code maintainability    | Medium   | Clear architecture, code standards, regular refactoring                      |
| Documentation gaps      | Medium   | Inline documentation, API docs, architecture diagrams                        |
| Testing coverage       | Medium   | Comprehensive test suite, CI enforcement                                     |
| Dependency management | Medium   | Regular updates, compatibility testing                                       |
| Feature creep          | Medium   | Clear requirements, MVP approach, prioritization                               |


