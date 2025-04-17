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

```
job-ready-simulator/
├── backend/                 # Backend services (Express.js)
│   ├── src/
│   │   ├── api/             # API endpoints
│   │   │   ├── controllers/ # Request handling logic
│   │   │   │   ├── auth.controller.ts
│   │   │   │   ├── challenge.controller.ts
│   │   │   │   ├── submission.controller.ts
│   │   │   │   └── user.controller.ts
│   │   │   ├── middleware/  # Express middleware
│   │   │   │   ├── auth.middleware.ts
│   │   │   │   ├── error.middleware.ts
│   │   │   │   └── validation.middleware.ts
│   │   │   ├── routes/      # Route definitions
│   │   │   │   ├── auth.routes.ts
│   │   │   │   ├── challenge.routes.ts
│   │   │   │   ├── submission.routes.ts
│   │   │   │   └── user.routes.ts
│   │   │   └── schemas/     # Request/response schemas (OpenAPI/JSON Schema)
│   │   │       ├── auth.schemas.ts
│   │   │       ├── challenge.schemas.ts
│   │   │       ├── submission.schemas.ts
│   │   │       └── user.schemas.ts
│   │   ├── lib/             # Shared libraries and utilities
│   │   │   ├── errors.ts       # Custom error classes
│   │   │   ├── logger.ts       # Logging utility
│   │   │   ├── prisma.ts     # Prisma client instance
│   │   │   ├── redis.ts       # Redis client instance
│   │   │   └── utils.ts        # General utility functions
│   │   ├── services/        # Business logic services
│   │   │   ├── auth.service.ts
│   │   │   ├── challenge.service.ts
│   │   │   ├── submission.service.ts
│   │   │   ├── user.service.ts
│   │   │   └── ai-feedback.service.ts
│   │   ├── app.ts           # Express application setup
│   │   └── server.ts        # Server entry point
│   ├── prisma/              # Prisma schema and migrations
│   │   ├── schema.prisma
│   │   └── migrations/
│   ├── test/               # Backend tests
│   │   ├── integration/     # Integration tests
│   │   └── unit/          # Unit Tests
│   ├── Dockerfile           # Dockerfile for backend service
│   ├── package.json         # Node.js dependencies
│   ├── tsconfig.json        # TypeScript configuration
│   └── .env.example          # Example environment variables
├── frontend/                # Frontend application (Next.js)
│   ├── public/
│   │   ├── fonts/         # Custom fonts
│   │   ├── images/       # Static images
│   │   └── favicon.ico   # Favicon
│   ├── src/
│   │   ├── app/             # Next.js App Router
│   │   │   ├── (auth)/       # Authentication routes (grouped)
│   │   │   │   ├── login/
│   │   │   │   │   └── page.tsx
│   │   │   │   ├── register/
│   │   │   │   │   └── page.tsx
│   │   │   │   └── forgot-password/
│   │   │   │       └── page.tsx
│   │   │   ├── (dashboard)/   # User dashboard (grouped)
│   │   │   │   ├── challenge/
│   │   │   │   │   └── [id]/
│   │   │   │   │       └── page.tsx  # Challenge details
│   │   │   │   ├── challenges/
│   │   │   │   │    └── page.tsx  # Challenge list
│   │   │   │   ├── profile/
│   │   │   │   │   └── page.tsx #User Profile
│   │   │   │   └── page.tsx # Main Dashboard
│   │   │   └── layout.tsx      # Root layout
│   │   ├── components/      # Reusable UI components
│   │   │   ├── ui/          # Base UI components (shadcn/ui)
│   │   │   │   ├── button.tsx
│   │   │   │   ├── input.tsx
│   │   │   │   ├── label.tsx
│   │   │   │   ├── ...
│   │   │   ├── challenge/     # Challenge-related components
│   │   │   │   ├── challenge-card.tsx
│   │   │   │   ├── challenge-editor.tsx
│   │   │   │   ├── challenge-header.tsx
│   │   │    └── test-results.tsx
│   │   │   ├── auth/          # Authentication Components
│   │   │   │   ├── login-form.tsx
│   │   │   │   └── register-form.tsx
│   │   │   └── feedback/        # AI feedback components
│   │   │       ├── feedback-display.tsx
│   │   │       └── feedback-progress.tsx
│   │   ├── lib/             # Utilities and helpers
│   │   │   ├── api/         # API integration
│   │   │   │   ├── auth.ts
│   │   │   │   ├── challenges.ts
│   │   │   │   └── submissions.ts
│   │   │   ├── state/       # Zustand stores
│   │   │   │   ├── auth-store.ts
│   │   │   │   └── challenge-store.ts
│   │   │   └── utils.ts     # General utilities
│   │   ├── styles/          # Global styles and CSS modules
│   │   │   └── globals.css
│   │   └── types/              # TypeScript type definitions
│   │        ├── index.ts
│   ├── test/         # Frontend Test
│   │   ├── e2e/       # End to End test (playwright)
│   │   │    └── challenge-submission.spec.ts
│   │   └── unit/      # Unit Tests
│   ├── .env.example
│   ├── .eslintrc.json
│   ├── .prettierrc.json
│   ├── next-env.d.ts
│   ├── next.config.js
│   ├── package.json
│   ├── postcss.config.js
│   ├── tailwind.config.ts
│   └── tsconfig.json
├── infrastructure/          # Infrastructure as Code (Terraform - Phase 3)
│   ├── modules/
│   │   ├── database/
│   │   ├── network/
│   │   └── compute/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── docs/                    # Project documentation
│   ├── architecture.md      # System architecture documentation
│   ├── api-documentation.md # OpenAPI specification
│   ├── contributing.md      # Contribution guidelines
│   └── style-guide.md       # Coding style guide
├── scripts/                 # Utility scripts (e.g., data seeding)
│   ├── seed-db.ts
│   ├── generate-openapi.ts
│   └── setup-project.sh     # Project setup script
├── docker-compose.yml       # Docker Compose configuration
└── README.md                # Project README
```

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

```

**AI Instruction:** Ensure that after running `setup-project.sh`, running `tree job-ready-simulator` in the terminal produces the *exact* directory structure shown above.  The script must be idempotent.

**Naming Conventions:**

*   **Files and Directories:** `kebab-case` (e.g., `user-profile.tsx`, `auth-service.ts`).
*   **Components (React):** `PascalCase` (e.g., `UserProfile`, `ChallengeList`).
*   **Next.js Pages:** For files within the `app` directory (using the App Router), use `kebab-case` for route segments (directory names) and `page.tsx` for the page component itself.  Example: `app/my-account/page.tsx` creates the route `/my-account`.
*   **Functions and Variables:** `camelCase` (e.g., `getUserProfile`, `challengeData`).
*   **Classes:** `PascalCase` (e.g., `UserService`, `DatabaseConnection`).
*   **Constants:** `UPPER_SNAKE_CASE` (e.g., `API_BASE_URL`, `MAX_RETRIES`).
*   **Interfaces (TypeScript):** Prefix with `I` (e.g., `IUser`, `IChallenge`).
*   **Types (TypeScript):** `PascalCase` (e.g., `UserRole`, `ChallengeDifficulty`).
*   **Database Tables:** `snake_case` with plural form (e.g., `users`, `challenges`, `submissions`).
*   **Database Columns:** `snake_case` (e.g., `user_id`, `created_at`, `is_active`).
*   **CSS Classes:** `BEM` methodology, using `kebab-case` (e.g., `.button`, `.button--primary`, `.button__icon`).
* **Environment Variables**: `UPPER_SNAKE_CASE` (e.g. `DATABASE_URL`)

### 1.2 Dependency Management

**AI Instruction:** Use `npm` (Node Package Manager) for both frontend and backend. Use `npm ci` for consistent builds in CI/CD. Pin dependencies to *exact* versions to ensure reproducibility.  *Never* use `latest`. Always specify a concrete version number. For each dependency listed below, install it using the exact version specified.

**Backend (Express.js):**

*File: `backend/package.json`*

```json
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
```

**Frontend (Next.js):**

*File: `frontend/package.json`*

```json
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
```

**Installation Commands (AI Instruction):**

To install dependencies, navigate to the `backend` and `frontend` directories separately and run:

```bash
npm install <package-name>@<exact-version>
```

For example:

*   `npm install express@4.18.2`
*   `npm install @prisma/client@5.4.2`
*   `npm install react@18.2.0`
*   `npm install zod@3.22.4`

For devDependencies, use:

```bash
npm install --save-dev <package-name>@<exact-version>
```
For example:
*  `npm install --save-dev typescript@5.3.3`

**In CI/CD environments, *always* use `npm ci` for clean, consistent, and reproducible installations based on `package-lock.json`.  Do *not* use `npm install` in CI/CD.**

### 1.3 Build System Configuration

**Backend (Express.js with TypeScript):**

*File: `backend/tsconfig.json`*

```json
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
```

**Explanation:**

*   `target`: Sets the ECMAScript target version to ES2022 for modern JavaScript features.
*   `module`: Sets the module system.
*   `moduleResolution`: Specifies the module resolution strategy (Node.js).
*   `lib`: Specifies the library files to be included in the compilation.
*   `outDir`: Specifies the output directory for compiled files.
*   `rootDir`: Specifies the root directory of input files.
*   `strict`: Enables all strict type-checking options.
*   `esModuleInterop`: Enables interoperability between CommonJS and ES Modules.
*   `skipLibCheck`: Skips type checking of declaration files.
*   `forceConsistentCasingInFileNames`: Ensures consistent casing in file names.
*   `resolveJsonModule`: Allows importing JSON modules.
*   `sourceMap`: Generates source map files for debugging.
*   `declaration`: Generates corresponding '.d.ts' files.
*   `include`: Specifies which files to include in the compilation.
*   `exclude`: Specifies which files to exclude from the compilation.
*  `removeComments`: Remove comments during transpilation.
* `emitDecoratorMetadata`, `experimentalDecorators`: Enables decorator features.
* `incremental`: Enable incremental compilation
* `noFallthroughCasesInSwitch`: Report errors for fallthrough cases in switch statement

**Frontend (Next.js):**

Next.js handles most of the build configuration automatically. However, we'll configure PostCSS and Tailwind.

*File: `frontend/postcss.config.js`*

```javascript
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};
```

*File: `frontend/tailwind.config.ts`*

```typescript
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
```

**Build Commands:**

*   **Backend Build:** `npm run build` (transpiles TypeScript to JavaScript)
*   **Frontend Build:** `npm run build` (creates an optimized production build)
*  **Start server (Backend):** `npm run start`
*  **Start server (Frontend):** `npm run start`

### 1.4 Development Environment Setup

**AI Instruction:** Follow these steps to set up the development environment.  These instructions assume a Unix-like environment (Linux, macOS, or WSL on Windows).

1.  **Install Node.js and npm:** Install Node.js (version 20 LTS) and npm. Verify installation by running `node -v` and `npm -v` in your terminal.  Use a Node version manager like `nvm` to manage multiple Node.js versions.

    ```bash
    # Example using nvm:
    nvm install 20
    nvm use 20
    node -v  # Should output v20.x.x
    npm -v   # Should output a version number
    ```

2.  **Install Docker and Docker Compose:** Install Docker Desktop (which includes Docker Compose) from the official Docker website. Verify installation:

    ```bash
    docker -v
    docker compose version
    ```
3. **Install psql:** to be able to run your SQL files you need to install `psql`
   ```bash
    # for debian based os
    sudo apt-get update
    sudo apt-get install postgresql-client

    # for mac
    brew install libpq
    brew link --force libpq
   ```

4.  **Clone Repository:** Clone the project repository using Git:

    ```bash
    git clone <repository_url>
    cd <repository_name>
    ```

5.  **Install Dependencies:**

    ```bash
    cd backend
    npm install
    cd ../frontend
    npm install
    ```

6.  **Set Up Environment Variables:**

    *   Create a `.env` file in the `backend` directory by copying `.env.example`: `cp .env.example .env`
    *   Create a `.env` file in the `frontend` directory by copying `.env.example`: `cp .env.example .env`
    *   Fill in the required environment variables in both `.env` files.  **Do not commit `.env` files to the repository.**  They contain secrets. At a minimum, you will need to set:
        *   `DATABASE_URL` (backend) -  Use `postgresql://postgres:postgres@pgbouncer:6432/kodelab` for local development with Docker Compose.
        *   `REDIS_URL` (backend) - Use `redis://redis:6379` for local development.
        *  `SESSION_SECRET` (backend) - Generate a strong, random string.
        *   `JWT_SECRET` (backend) - Generate a strong, random string.
        *   `JWT_REFRESH_SECRET` (backend) - Generate a *different* strong, random string.
        *   `OPENAI_API_KEY` (backend) - Your OpenAI API key.
        * `NEXT_PUBLIC_API_URL` (frontend) - Use `http://localhost:4000` for local development.

7.  **Database Setup (PostgreSQL):**

    *   Start the database and supporting services using Docker Compose:

        ```bash
        docker compose up -d db pgbouncer redis
        ```

    *   Run Prisma migrations to create the database schema:

        ```bash
        cd backend
        npx prisma migrate dev --name init
        ```

8.  **Run the Application:**

    *   Start the backend development server:

        ```bash
        cd backend
        npm run dev
        ```

    *   Start the frontend development server:

        ```bash
        cd frontend
        npm run dev
        ```

9.  **IDE Configuration:**

    *   **Recommended IDE:** VS Code.
    *   **Install Extensions:**
        *   ESLint
        *   Prettier - Code formatter
        *   Prisma
        *   Docker
        *   Tailwind CSS IntelliSense
        *   Code Spell Checker
        *   GitLens

10. **VS Code Settings:** Create a `.vscode` directory in the root of the project. Inside, create a `settings.json` file:

    ```json
    {
      "editor.formatOnSave": true,
      "editor.defaultFormatter": "esbenp.prettier-vscode",
      "[javascript]": {
```json
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
  "typescript.tsdk": "frontend/node_modules/typescript/lib", // For frontend, use local TS version
    "files.eol": "\n" // Enforce LF line endings
}
```

11. **Debugging Configuration:** Create a `.vscode/launch.json` file:

    ```json
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
    *   Request reviews from at least one other developer.  *AI agents should request review from a designated "lead" AI agent or a human reviewer.*

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

*   **Purpose:** Manages user authentication, authorization, and session management. Provides secure access control to protected resources. Implements robust security measures.
*   **Input:**
    *   `POST /api/v1/auth/register`:  `{ name: string, email: string, password: string }`
    *   `POST /api/v1/auth/login`: `{ email: string, password: string }`
    *   `POST /api/v1/auth/github`: `{ code: string }`
    *   `GET /api/v1/auth/me`: `Authorization: Bearer <token>`
    *   `POST /api/v1/auth/logout`: `Authorization: Bearer <token>`
    *   `POST /api/v1/auth/refresh`: `{ refreshToken: string }`
    *    `GET /api/v1/auth/csrf-token`:
*   **Output:**
    *   `/register`, `/login`, `/github`: `{ token: string, refreshToken: string, user: { id: string, email: string, name: string, role: string }}`
    *   `/me`: `{ user: { id: string, email: string, name: string, role: string }}`
    *   `/logout`: `{ success: boolean }`
    *  `/refresh`: ` { token: string, refreshToken: string }`
    *  `/csrf-token`: `{ csrfToken: string }`
*   **Interfaces:**
    *   REST API endpoints (as defined in Input).
*   **Internal Logic:**
    1.  **Registration:**
        *   Validate input data (email format, password strength, name length) using `zod`.
        *   Check for existing user with the same email using `prisma`.
        *   Hash the password using `bcrypt` with a cost factor of 12.
        *   Create a new user record in the database using `prisma`.
        *   Generate a JWT (JSON Web Token) using `jsonwebtoken`. Sign with `process.env.JWT_SECRET` and set `expiresIn: '1h'`.
        *   Generate a refresh token using `jsonwebtoken`.  Sign with a *different* secret, `process.env.JWT_REFRESH_SECRET`, with `expiresIn: '7d'`.
        *   Store the refresh token in an HttpOnly, Secure, SameSite=Strict cookie.
        *   Return the JWT (access token) and user information in the response body.
    2.  **Login:**
        *   Validate input data using `zod`.
        *   Retrieve user record from the database by email using `prisma`.
        *   Verify the password hash using `bcrypt.compare`.
        *   If credentials are invalid, throw an `UnauthorizedError`.
        *   Generate a new JWT (access token) and refresh token.
        *   Store the refresh token in an HttpOnly, Secure, SameSite=Strict cookie.
        *   Return the JWT and user information.
    3.  **GitHub OAuth:**
        *   Exchange the authorization `code` with GitHub for an access token using `axios`.
        *   Fetch the user's profile information from GitHub using the access token.
        *   If a user with the GitHub ID exists (check `githubId` field), log them in (generate JWT/refresh token).
        *   If no user exists with that GitHub ID, check if a user with the *same email* exists. If so, link the GitHub ID to the existing user.
        *   If no user exists with the same email, create a new user record and log them in.
        *   *Always* link existing accounts by email if possible, to prevent duplicate accounts.
    4.  **Logout:**
        *   Add the JWT (access token) to a blacklist in Redis to invalidate it. Use the token's expiration time as the TTL for the Redis entry.
        *   Clear the refresh token cookie.
    5.  **Token Refresh:**
        *   Verify the refresh token. If invalid or expired, return a 401 error.
        *   Generate a new JWT (access token) and a new refresh token.
        *   Invalidate the old refresh token (add to blacklist or remove from database).
        *   Store the new refresh token securely.
        * Return new access, and refresh tokens.
    6.  **Get Current User (/me):**
        *   Verify the JWT (access token) from the `Authorization` header.
        *   Fetch user information from the database by `userId` (extracted from the token) using `prisma`.
    7. **Get CSRF Token:**
       * Generate CSRF token.
*   **Dependencies:**
    *   `prisma`: Database access.
    *   `bcrypt`: Password hashing.
    *   `jsonwebtoken`: JWT generation and verification.
    *   `ioredis`: Redis client for token blacklisting and session management.
    *   `axios`: HTTP requests for OAuth.
    *   `zod`: Input validation.
    *  `cookie-parser`: Parse Cookie header and populate req.cookies.
    * `csurf`: CSRF protection middleware.

*   **Error Handling:**
    *   `400 Bad Request`: Invalid input data.  Return specific validation errors from Zod.
    *   `401 Unauthorized`: Invalid credentials, missing or expired token.
    *   `403 Forbidden`: Insufficient permissions.
    *   `409 Conflict`: User already exists.
    *   `500 Internal Server Error`: Unexpected errors.  Log detailed error information, but do *not* expose internal error details to the client.
*   **Testing:**
    *   **Unit Tests:** Test individual functions (e.g., password hashing, JWT generation, input validation, token refresh logic).  Mock external dependencies (database, Redis, OAuth providers).
    *   **Integration Tests:** Test the entire authentication flow (registration, login, logout, token refresh, /me). Test with valid and invalid data. Test different roles and permissions.  Test OAuth flow with a mock OAuth provider.
* **Concurrency:**
    *   Use asynchronous operations (Promises/async/await) to handle multiple requests concurrently.
    *   Use connection pooling for database access (handled by Prisma).
    *   Use rate limiting to prevent abuse (see `middleware/rate-limit.middleware.ts`).
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

*   **Purpose:** Manages coding challenges, including creation, retrieval, updating, and deletion.
*   **Input:**
    *   `GET /api/v1/challenges`: (Optional query parameters: `difficulty`, `category`, `tags`, `search`, `page`, `limit`, `sortBy`, `sortOrder`)
    *   `GET /api/v1/challenges/:id`:
    *   `POST /api/v1/challenges`: `{ title: string, description: string, difficulty: string, category: string, instructions: string, starterCode: string, solutionCode: string, testCases: object[], hints: string[], tags: string[], estimatedTime: number, isPublic: boolean }` (Requires authentication and instructor/admin role)
    *   `PUT /api/v1/challenges/:id`:  (Same fields as POST, but all optional) (Requires authentication and ownership/admin role)
    *   `DELETE /api/v1/challenges/:id`: (Requires authentication and ownership/admin role)
    *  `GET /api/v1/challenges/categories`:
*   **Output:**
    *   `/api/v1/challenges`: `{ challenges: Challenge[], pagination: { page: number, limit: number, total: number, pages: number } }`
    *   `/api/v1/challenges/:id`: `{ challenge: Challenge }`
    *   `/api/v1/challenges`: (POST/PUT) `{ challenge: Challenge }`
    *   `/api/v1/challenges/:id`: (DELETE) `{ success: boolean }`
    *    `/api/v1/challenges/categories`: `{ categories: string[] }`
*   **Interfaces:**
    *   REST API endpoints (as defined in Input).
    *   `Challenge` data type: (defined in previous iteration)
*   **Internal Logic:**
    1.  **List Challenges:**
        *   Retrieve challenges from the database using `prisma.challenge.findMany`, applying filters (difficulty, category, search term, tags) and pagination (using `skip` and `take`).
        *   Calculate the total number of pages.
        *   Return a paginated list of challenges and pagination metadata: `{challenges: [], pagination: { page, limit, total, pages } }`.
    2.  **Get Challenge:**
        *   Retrieve a challenge by ID using `prisma.challenge.findUnique`.
        *   If the challenge is not public (`isPublic: false`), check if the user is the creator (`createdById`) or an admin. If not, return a 403 Forbidden error.
        *  If user is student, remove `solutionCode` from the output.
        * Hide expected output in test cases that are set to private.
    3.  **Create Challenge:**
        *   Validate the input data (all required fields, data types, etc.) using `zod`.
        *   Verify the user's role (instructor or admin) using the `auth` middleware and the `authorize` function.
        *   Create a new challenge record in the database using `prisma.challenge.create`.
    4.  **Update Challenge:**
        *   Validate the input data using `zod`.
        *   Verify the user's role (creator or admin) and ownership using the `auth` middleware and the `verifyOwnership` function.
        *   Update the challenge record in the database using `prisma.challenge.update`.
    5.  **Delete Challenge:**
        *   Verify the user's role (creator or admin) and ownership using the `auth` middleware and the `verifyOwnership` function.
        *   Delete the challenge record from the database using `prisma.challenge.delete`.  Consider soft-delete for challenges with existing submissions.
        * If challenge has submissions, soft delete, otherwise delete the record.
    6.  **Get Categories:**
        *   Return all unique categories from public challenges.
*   **Dependencies:**
    *   `prisma`: Database access.
    *   `zod`: Input validation.

*   **Error Handling:**
    *   `400 Bad Request`: Invalid input data.  Return specific validation errors from Zod.
    *   `401 Unauthorized`: User not authenticated.
    *   `403 Forbidden`: User does not have permission (not an instructor/admin, or not the owner of the challenge).
    *   `404 Not Found`: Challenge not found.
    *   `500 Internal Server Error`: Unexpected errors. Log detailed error information.

*   **Testing:**
    *   **Unit Tests:** Test individual functions (e.g., input validation, filtering logic, pagination logic).
    *   **Integration Tests:** Test the entire API endpoints, including database interactions.  Test listing challenges with various filters and pagination. Test getting a challenge with and without authentication, and with public and private challenges. Test creating, updating, and deleting challenges with different user roles.

* **Concurrency:** Use asynchronous operations (Promises/async/await). Database operations are handled concurrently by Prisma and the database connection pool.

#### 2.1.3 Submission Service (`submission-service`)

*   **Purpose:** Handles code submissions, executes tests, coordinates feedback generation, and updates user progress.  This is a *critical* service for the platform.
*   **Input:**
    *   `POST /api/v1/submissions`: `{ challengeId: string, language: string, code: string }` (Requires authentication)
    *   `GET /api/v1/submissions/:id`: (Requires authentication and ownership/admin/challenge-creator role)
    *   `GET /api/v1/submissions/:id/feedback`: (Requires authentication and ownership/admin/challenge-creator role)
    *   `POST /api/v1/submissions/:id/feedback/regenerate`: (Requires authentication and ownership/admin role, and premium/admin)
    *    `GET /api/v1/submissions/feedback/job/:jobId`: (Requires authentication and ownership/admin/challenge-creator role)
    * `GET /api/v1/submissions/user`: Get current user submission, with pagination.
*   **Output:**
    *   `/api/v1/submissions`: `{ submissionId: string, status: string, testResults: object[] | null, feedback: object | null, feedbackStatus: string | null }`
    *  `/api/v1/submissions/:id`:  `{ submission: Submission, testResults: object[] | null, feedbackStatus: string | null}`
    *   `/api/v1/submissions/:id/feedback`:  `{ feedback: Feedback | null, status: string, message: string }`
    *   `/api/v1/submissions/:id/feedback/regenerate`: `{ jobId: string}`
    *   `/api/v1/submissions/feedback/job/:jobId`:  `{ status: string, feedback?: Feedback}`
    * `/api/v1/submissions/user`: `{ submissions: Submission[], pagination: { page: number, limit: number, total: number, pages: number } }`
*   **Interfaces:**
    *   REST API endpoints (as defined in Input).
    *   `Submission` data type: (defined in previous iteration)
    * `Feedback` data type: (defined in previous iteration)

*   **Internal Logic:**
    1.  **Submit Code:**
        *   Validate input data (challenge ID exists, language is supported, code is not empty) using `zod`.
        *   Create a new submission record in the database with status "PENDING" using `prisma`.
        *   Retrieve the challenge details (test cases) using the `challengeService`.
        *   Enqueue a job for code execution using the `bull` queue. The job ID *is* the submission ID. This ensures a 1:1 mapping between submissions and execution jobs.
        * Return the submissionId, and status to user.
    2.  **Get Submission:**
        *   Retrieve a submission by ID using `prisma`.
        *   Verify that the requesting user is the owner of the submission, the creator of the challenge, or an admin.
    3.  **Get Feedback**:
        * Check the feedback is ready, if yes, return the result.
        * Check if feedback is in progress, if so, return `pending` status.
        * If there is no feedback for the submission, initiate feedback request, and return `pending` status.
    4.  **Regenerate Feedback**:
         * Only owner or admin can regenerate a feedback.
         * Only submission with passed tests can regenerate a feedback.
         * Check regenerate feedback limit for the user.
         * Delete the existing feedback, and queue feedback generation, and return job id.
    5. **Check feedback Job**:
        * Check the JobID status, if finished return feedback, otherwise show status.
    6. **Get User Submission**:
        * Get user's submission, and add pagination to it.
    7.  **Code Execution (in a separate worker process):**
        *   Dequeue a submission job from the `code-execution` queue (using `bull`).
        *   Create a secure execution environment (Docker container) using `dockerode`.
        *   Select the correct Docker image based on the submission language (see 9.3 for Dockerfiles).
        *   Copy the user's code and the challenge's test cases into the container.
        *   Execute the user's code against the test cases using the appropriate test runner:
            *   **JavaScript:** `node --expose-internals ./node_modules/vitest/vitest.mjs run --reporter=json --outputFile=test-results.json` (within a `vm2` sandbox).
            *   **Python:** `python -m pytest -v --json-report --json-report-file=test-results.json` (with resource limits set using the `resource` module).
            *   **Java:**  `mvn test -DargLine=-Dfile.encoding=UTF-8 -Dmaven.test.failure.ignore=true -Dtest=SolutionTest` (using JUnit 5 and Maven).
            * **SQL**: `psql -U postgres -d testdb -f /app/test.sql`
        *   Capture the test results (pass/fail, output, errors), execution time, and memory usage. Use `docker stats` for resource monitoring during execution.
        *   Parse the test results from the generated JSON output file (e.g., `test-results.json`).
        *   Update the submission record in the database with the results using `prisma`. Update the status to "PASSED", "FAILED", or "ERROR" accordingly.
        *   If the submission passed all tests, trigger AI feedback generation (asynchronously, via a direct call to the `aiFeedbackService`).
    8.  **AI Feedback Generation (in a separate worker process or service - `ai-feedback.service.ts`):**
        *   Dequeue a feedback generation job from the `ai-feedback` queue (using `bull`).
        * Check for cached feedback (using a hash of the normalized code + language + challenge ID as the key) using `redis`.
        *   If no cache hit, check for similar submissions using vector embeddings (using `prisma` and the `aiProvider` for embedding generation).
        *  If no similar submission, analyze code for patterns, and return pattern-based feedback.
        *   If no cache/similar submission/pattern is found, check user quota.
        *   If the user has quota, generate AI feedback using the appropriate prompt and model (OpenAI/Claude) via `aiProvider`.
        *   Parse the AI's response and extract the relevant information (strengths, weaknesses, suggestions, conceptual errors, score).  Validate the response format.
        *   Save the feedback to the database and associate it with the submission using `prisma`.
        *   Cache the feedback in Redis for future use.
        * If error happens, use fallback to basic feedback.

*   **Dependencies:**
    *   `prisma`: Database access.
    *   `bull`: Job queue for code execution and feedback generation.
    *   `dockerode`: Docker API for container management.
    *   `openai` or `anthropic`: AI API clients.
    *   `redis`: Cache and queue.
    *   `zod`: Input validation.
    *  `challengeService`: To retrieve challenge data.
    *  `aiFeedbackService`: To generate AI feedback.

*   **Error Handling:**
    *   `400 Bad Request`: Invalid input data. Return specific validation errors from Zod.
    *   `401 Unauthorized`: User not authenticated.
    *   `403 Forbidden`: User does not have permission (not the owner, challenge creator, or an admin).
    *   `404 Not Found`: Challenge or submission not found.
    *   `429 Too Many Requests`: Rate limit exceeded (for code execution or feedback generation). Implement using `express-rate-limit` and Redis.
    *   `500 Internal Server Error`: Unexpected errors, code execution errors, AI provider errors. Log detailed error information using `pino`.

*   **Testing:**
    *   **Unit Tests:** Test individual functions (e.g., input validation, test result parsing, feedback parsing). Mock external dependencies (database, AI provider, Docker).
    *   **Integration Tests:** Test the entire submission flow, including code execution, feedback generation, and database updates. Test with different languages, test cases, and error scenarios. Test caching and rate limiting.  Test with various AI models.
* **Concurrency:**
    * Use a job queue (`bull`) to handle code execution and feedback generation asynchronously, preventing blocking operations from affecting API responsiveness. The queue should have a concurrency limit to avoid overwhelming the system.
    *   Use connection pooling for database access (handled by Prisma).
    * Code execution and AI feedback generation are handled by separated workers.

#### 2.1.4 User Service (`user-service`)
*   **Purpose:** Manages user profiles, progress tracking, and user-related data.
*   **Input:**
    *   `GET /api/v1/users/me/profile`:  (Requires authentication)
    *   `PUT /api/v1/users/me/profile`: `{ name: string, profileImage?: string, settings?: object }` (Requires authentication)
    *  `GET /api/v1/users/me/progress`:  (Requires authentication)
    *  `GET /api/v1/users/me/submissions`: (Requires authentication)
*   **Output:**
     * `/api/v1/users/me/profile`: `{ profile: { id: string, name: string, email: string, role: string, profileImage: string, settings: object } }`
    *   `/api/v1/users/me/profile`: (PUT) `{ profile: { id: string, name: string, email: string, role: string, profileImage: string, settings: object} }`
    * `/api/v1/users/me/progress`: `{progressSummary: object, recentActivity: object[], categoryCompletion: object[], difficultyCompletion: object[], skillProgression: object[] }`
    * `/api/v1/users/me/submissions`: `{ submissions: Submission[], pagination: { page: number, limit: number, total: number, pages: number } }`
*   **Interfaces:**
    *   REST API endpoints (as defined in Input).
        *   `UserProfile` data type:
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
*   **Internal Logic:**
    1.  **Get User Profile:**
        *   Retrieve the user's profile information from the database using `prisma` and the user's ID (from the authentication token).
        *   Return the user profile data.
    2.  **Update User Profile:**
        *   Validate the input data using `zod`.
        *   Update the user's profile information in the database using `prisma`.
        *   Return the updated user profile data.
    3. **Get User Progress**:
        * Get all data related to user progress from different tables.
    4. **Get User Submissions:**
        * Get user's submission, with pagination.
*   **Dependencies:**
    *   `prisma`: Database access.
    *    `zod`: Input validation.
*   **Error Handling:**
    *   `400 Bad Request`: Invalid input data. Return specific validation errors.
    *   `401 Unauthorized`: User not authenticated.
    *   `404 Not Found`: User not found.
    *   `500 Internal Server Error`: Unexpected errors. Log detailed error information.
*   **Testing:**
    *   **Unit Tests:** Test individual functions (e.g., getting and updating profiles).
    *   **Integration Tests:** Test the API endpoints, including authentication and authorization.
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
  usageLogs     UsageLog[]

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
  Okay, I understand. I will continue generating the Master Project Blueprint, Version 3.0, from the last point, and this time I will ensure I complete the *entire* document, incorporating all previous feedback, additions, and instructions, without any omissions. I will focus on providing a single, self-contained, comprehensive document.

```markdown
  @@index([courseId])
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

**AI Instruction:** Use this Prisma schema to generate the database migrations and the Prisma client. Run migrations using: `npx prisma migrate dev --name <descriptive_migration_name>`. Review the generated SQL *before* applying the migration. To apply migrations in a production environment, use `npx prisma migrate deploy`.  Add comments to explain table and columns.

**Database Migration Strategy:**

*   Use Prisma Migrate for database migrations.
*   Each schema change should be accompanied by a new migration.
*   Migrations should be reversible (up and down).
*   Test migrations thoroughly in a development environment before applying them to staging or production.
* **AI Instruction:** When you modify `schema.prisma`, generate a migration using: `npx prisma migrate dev --name <descriptive_migration_name>`. Review the generated SQL *before* applying the migration.

**Data Validation:**

* Use Zod for validating the data before it reaches to database.

**Indexing Strategy:**

Indexes are defined within the Prisma schema using the `@@index()` attribute. See the schema above for specific index definitions.

**Connection Pooling:**
Use `PgBouncer` for connection pool.
Image: `edoburu/pgbouncer:1.18.0`

*File: `backend/config/pgbouncer.ini`*
```ini
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
```
*File: `backend/config/userlist.txt`*
```
"postgres" "postgres"
```

**Connection String (Backend):**

```
DATABASE_URL=postgresql://postgres:postgres@pgbouncer:6432/kodelab
```
**Docker compose file update:**
Add image to `pgbouncer`:
```yaml
  pgbouncer:
    image: edoburu/pgbouncer:1.18.0
```

### 2.3 Inter-Component Communication

*   **REST APIs:**  The primary method of communication between frontend and backend services and between backend services themselves.  Use JSON for data exchange. All API endpoints MUST be documented using the OpenAPI 3.0 specification.
*   **WebSockets (Future - Phase 2):**  For real-time features like collaborative coding and live feedback updates.  Use Socket.IO for WebSocket communication.
*   **Message Queue (Bull):**  For asynchronous tasks (code execution, AI feedback generation). The backend services communicate with each other and with worker processes through the Redis-backed Bull queue. The queue name for code execution is `code-execution`.  The queue name for AI feedback generation is `ai-feedback`.
* **Internal Service Calls:** Use http request for direct communication, and use service discovery for internal service calls.

**AI Instruction:** All API endpoints MUST be documented using the OpenAPI 3.0 specification. Generate client SDKs from the OpenAPI spec. Use descriptive names for endpoints and follow RESTful principles.

### 2.4 Security Considerations

*   **Authentication:**  All API requests (except for public endpoints like `/api/v1/challenges` for listing) require authentication via JWT.  JWTs are obtained through the `/api/v1/auth/login` or `/api/v1/auth/register` endpoints. The JWT must be included in the `Authorization` header as a Bearer token: `Authorization: Bearer <token>`.
*   **Authorization:**  Implement Role-Based Access Control (RBAC) to restrict access to certain endpoints based on user roles (student, instructor, admin).  Use the `auth` middleware and the `authorize` and `verifyOwnership` functions for authorization checks.
*   **Data Validation:**  Validate *all* user inputs using Zod schemas to prevent injection attacks and ensure data integrity.  Validate data on both the frontend (for user experience) and the backend (for security).
*   **Rate Limiting:**  Implement rate limiting on all API endpoints to prevent abuse. Use the `express-rate-limit` middleware with a Redis store.  Configure different rate limits for different endpoints and user roles.
*   **Secure Code Execution:**  Execute user-submitted code in isolated Docker containers with limited resources and network access (see Section 9 for details).
*   **Data Encryption:**  Encrypt sensitive data at rest (database) and in transit (HTTPS). Use TLS 1.3 for all HTTPS connections.
*   **Regular Security Audits:** Perform regular security audits and vulnerability scans (see Section 10.4).
* **CSRF Protection:** Implement CSRF protection using the `csurf` middleware. All state-changing requests (POST, PUT, DELETE) MUST include a valid CSRF token. The frontend MUST obtain the CSRF token from the `/api/v1/auth/csrf-token` endpoint and include it in the `X-CSRF-Token` header for all subsequent requests. The cookie settings should be: `httpOnly: true`, `secure: true` (in production), and `sameSite: 'strict'`.
* **Content Security Policy:** Implement it using `helmet` middleware.

## 3. Feature Implementation

### 3.1 User Story Breakdown

**(Example - Already provided in previous iteration. This structure should be followed for ALL user stories.)**

### 3.2 Task Implementation Example (Detailed)

**(Already provided in previous iteration. This level of detail should be maintained for ALL tasks.)**

## 4. Detailed Feature Specifications

### 4.1 Task Library
(Content already provided and is complete)
The task library is the core of the platform, offering practical, job-relevant coding challenges. Below are eight detailed tasks, with order and UI presentation designed to guide users progressively from foundational to advanced skills.

#### Task Order and UI Presentation

**Order**: Tasks are presented in a searchable, filterable list, grouped by difficulty (Beginner → Intermediate → Expert) and category (e.g., APIs, Databases, Security). Beginners start with foundational tasks (e.g., JSON parsing), progressing to complex ones (e.g., securing web apps).

**UI Process**: Users select a task from the list, view its description, write code in an editor, submit it for execution against test cases, and receive feedback. Tasks link together contextually—e.g., mastering API debugging (Task 1) aids CRUD API development (Task 6).

**Difficulty Progression System**: Tasks within each category follow a calibrated difficulty curve with five levels:

- **Foundational**: Basic concepts application (Levels 1-2)
- **Practical**: Standard industry patterns (Levels 3-5)
- **Challenging**: Complex scenarios requiring multiple skills (Levels 6-7)
- **Advanced**: Edge cases and optimization (Level 8)
- **Expert**: Production-quality implementations (Levels 9-10)

**Skill Mapping**: Each task is tagged with specific job skills and roles:

- **Roles**: Backend Developer, Frontend Developer, DevOps Engineer, etc.
- **Skills**: API Integration, Database Optimization, Security Hardening, etc.
- **Tools**: Docker, PostgreSQL, React, Flask, etc.

#### Task 1: Debug REST API 404 Error

**Title**: Fix a Broken API Call

**Description**: A Python script using requests fails with a 404 error. Identify and correct the issue based on provided logs and requirements (e.g., GET data from http://api.example.com/users).

**Test Cases**:

- Incorrect URL: Input: htp://api.example.com/users, Expected: Fix to http://api.example.com/users, Output: 200 OK.
- Missing Headers: Input: No Accept header, Expected: Add headers={'Accept': 'application/json'}, Output: JSON response.
- Invalid Endpoint: Input: /userss, Expected: Fix to /users, Output: User list.
- No API Key: Input: Missing api_key param, Expected: Add params={'api_key': 'xyz'}, Output: Authorized response.
- Timeout Issue: Input: No timeout, Expected: Add timeout=5, Output: Graceful error if server delays.

**Difficulty**: Intermediate

**Required Knowledge**: HTTP, Python requests, debugging.

**Ideal Solution**:

```python
import requests
response = requests.get('http://api.example.com/users', headers={'Accept': 'application/json'}, params={'api_key': 'xyz'}, timeout=5)
print(response.json())
```

**Estimated Time**: 15 minutes

**Learning Objectives**: Master API request structures, error diagnosis.

**Specific Skills**: API Calls—Understanding endpoints, headers, and authentication.

**Industry Application**: This task simulates a common scenario faced by developers working with external APIs in fintech, e-commerce, or data aggregation roles.

#### Task 2: Optimize SQL Query for Performance

**Title**: Speed Up a Slow Query

**Description**: Optimize a sluggish SQL query retrieving sales data from a 1M-row table (SELECT \* FROM sales WHERE date > '2023-01-01').

**Test Cases**:

- No Index: Input: No index on date, Expected: Add CREATE INDEX idx_date ON sales(date), Output: <1s runtime.
- Inefficient Join: Input: INNER JOIN customers ON sales.id = customers.id, Expected: Reorder or index id, Output: Optimized runtime.
- Subquery: Input: WHERE id IN (SELECT id FROM customers), Expected: Convert to JOIN, Output: Faster execution.
- Unselective Filter: Input: Broad WHERE, Expected: Add region='US', Output: Smaller result set.
- Large Result: Input: Full table scan, Expected: Limit to TOP 100, Output: Reduced load.

**Difficulty**: Expert

**Required Knowledge**: SQL, indexing, query planning.

**Ideal Solution**:

```sql
CREATE INDEX idx_date ON sales(date);
SELECT TOP 100 s.* FROM sales s INNER JOIN customers c ON s.id = c.id WHERE s.date > '2023-01-01' AND s.region = 'US';
```

**Estimated Time**: 30 minutes

**Learning Objectives**: Learn query optimization, indexing strategies.

**Specific Skills**: SQL—Query tuning, index application.

**Execution Environment**: PostgreSQL 15 with EXPLAIN ANALYZE support and query plan visualization.

#### Task 3: Parse and Validate JSON Data

**Title**: Clean Up Messy JSON

**Description**: Parse a JSON string and validate it against a schema (e.g., {"name": str, "age": int}) using Python.

**Test Cases**:

- Valid JSON: Input: {"name": "Alice", "age": 25}, Expected: No change, Output: Validated.
- Syntax Error: Input: {name: "Bob", "age": 30}, Expected: Fix to {"name": "Bob", "age": 30}, Output: Validated.
- Type Mismatch: Input: {"name": "Charlie", "age": "28"}, Expected: Fix to 28, Output: Validated.
- Missing Key: Input: {"name": "Dave"}, Expected: Add "age": null, Output: Validated.
- Large JSON: Input: 10MB file, Expected: Stream parsing, Output: Validated without crash.

**Difficulty**: Beginner

**Required Knowledge**: JSON, Python json module.

**Ideal Solution**:

```python
import json
data = json.loads('{"name": "Alice", "age": 25}')
schema = {"name": str, "age": int}
for key, type_ in schema.items(): assert isinstance(data[key], type_)
```

**Estimated Time**: 10 minutes

**Learning Objectives**: Understand JSON parsing, validation basics.

**Specific Skills**: JSON Handling—Parsing, schema enforcement.

**Extensions Available**: Advanced solution using JSON Schema validation for premium users.

#### Task 4: Write Unit Tests for a Function

**Title**: Test a Math Function

**Description**: Write unit tests for def add(a: int, b: int) -> int.

**Test Cases**:

- Happy Path: Input: add(2, 3), Expected: 5.
- Negative Numbers: Input: add(-1, -2), Expected: -3.
- Zero: Input: add(0, 5), Expected: 5.
- Type Error: Input: add("2", 3), Expected: Raise TypeError.
- Large Input: Input: add(106, 106), Expected: 2,000,000.

**Difficulty**: Intermediate

**Required Knowledge**: Unit testing, Python unittest.

**Ideal Solution**:

```python
import unittest
def add(a: int, b: int) -> int: return a + b
class TestAdd(unittest.TestCase):
    def test_happy_path(self): self.assertEqual(add(2, 3), 5)
    def test_negative(self): self.assertEqual(add(-1, -2), -3)
    def test_large(self): self.assertEqual(add(10**6, 10**6), 2000000)
    def test_type_error(self): self.assertRaises(TypeError, add, "2", 3)
```

**Estimated Time**: 20 minutes

**Learning Objectives**: Master unit testing, edge case handling.

**Specific Skills**: Testing—Test case design, assertions.

**Industry Connection**: Test-driven development practices used at companies like Google, Microsoft, and Amazon.

#### Task 5: Process Multiple Files with Exception Handling

**Title**: Robust File Processor

**Description**: Process multiple CSV files, handling exceptions gracefully.

**Test Cases**:

- File Not Found: Input: missing.csv, Expected: Skip with log, Output: Continue.
- Permission Denied: Input: Locked file, Expected: Skip with log, Output: Continue.
- Malformed CSV: Input: Bad row, Expected: Skip row, Output: Partial result.
- Large File: Input: 1GB CSV, Expected: Chunked processing, Output: Full result.
- Empty File: Input: 0 bytes, Expected: Log and skip, Output: No crash.

**Difficulty**: Advanced

**Required Knowledge**: File I/O, exceptions, Python csv.

**Ideal Solution**:

```python
import csv, logging
logging.basicConfig(level=logging.INFO)
def process_files(filenames):
    for fn in filenames:
        try:
            with open(fn, 'r') as f:
                reader = csv.reader(f)
                for row in reader: print(row)
        except FileNotFoundError: logging.info(f"{fn} not found")
        except PermissionError: logging.warning(f"No access to {fn}")
```

**Estimated Time**: 25 minutes

**Learning Objectives**: Learn robust exception handling, file processing.

**Specific Skills**: Exception Handling—Error recovery, logging.

**Related Tasks**: Links to data validation and transformation tasks.

#### Task 6: Implement CRUD API with Flask

**Title**: Build an Inventory API

**Description**: Create a RESTful API for inventory management using Flask.

**Test Cases**:

- Create: Input: POST /items {"name": "Book", "qty": 10}, Expected: 201 Created.
- Read: Input: GET /items, Expected: 200 OK, JSON list.
- Update: Input: PUT /items/1 {"qty": 15}, Expected: 200 OK.
- Delete: Input: DELETE /items/1, Expected: 204 No Content.
- Invalid Data: Input: POST /items {"qty": "abc"}, Expected: 400 Bad Request.

**Difficulty**: Intermediate

**Required Knowledge**: REST, Flask, HTTP.

**Ideal Solution**:

```python
from flask import Flask, request, jsonify
app = Flask(__name__)
items = []
@app.route('/items', methods=['POST'])
def create_item():
    data = request.json
    items.append(data)
    return jsonify(data), 201
```

**Estimated Time**: 30 minutes

**Learning Objectives**: Understand API development, CRUD operations.

**Specific Skills**: API Development—Routing, request handling.

**OpenAPI Documentation**: Premium users receive automatically generated API documentation.

#### Task 7: Secure Web App Against Vulnerabilities

**Title**: Harden a Web App

**Description**: Fix security issues in a Flask app (e.g., vulnerable login form).

**Test Cases**:

- SQL Injection: Input: '; DROP TABLE users; --, Expected: Use parameterized queries, Output: Safe execution.
- XSS: Input: <script>alert(1)</script>, Expected: Sanitize input, Output: Escaped text.
- CSRF: Input: No token, Expected: Add CSRF token, Output: Protected POST.
- Insecure Deps: Input: Outdated Flask, Expected: Update to latest, Output: No vuln.
- Brute Force: Input: 100 login attempts, Expected: Rate limit, Output: 429 Too Many Requests.

**Difficulty**: Expert

**Required Knowledge**: Web security, OWASP, Flask.

**Ideal Solution**:

```python
from flask import Flask, request
from bleach import clean
app = Flask(__name__)
@app.route('/login', methods=['POST'])
def login():
    username = clean(request.form['username'])
    # Parameterized SQL query
    return "Logged in", 200
```

**Estimated Time**: 40 minutes

**Learning Objectives**: Master secure coding, vulnerability mitigation.

**Specific Skills**: Security—Injection prevention, sanitization.

**Security Report**: Premium users receive a detailed vulnerability analysis report.

#### Task 8: Implement Pagination in a Web Application

**Title**: Paginate a Long List

**Description**: Add pagination to a Flask app listing items.

**Test Cases**:

- First Page: Input: GET /items?page=1, Expected: Items 1-10.
- Second Page: Input: GET /items?page=2, Expected: Items 11-20.
- Last Page: Input: GET /items?page=10, Expected: Final items.
- Invalid Page: Input: GET /items?page=999, Expected: 404 Not Found.
- Large Dataset: Input: 1M items, Expected: Efficient slicing, Output: Fast response.

**Difficulty**: Intermediate

**Required Knowledge**: Pagination, Flask, SQL.

**Ideal Solution**:

```python
from flask import Flask, request
app = Flask(__name__)
items = list(range(1000))
@app.route('/items')
def get_items():
    page = int(request.args.get('page', 1))
    per_page = 10
    start = (page - 1) * per_page
    end = start + per_page
    return jsonify(items[start:end])
```

**Estimated Time**: 20 minutes

**Learning Objectives**: Learn pagination, UI navigation.

**Specific Skills**: Pagination—Offset calculation, query slicing.

**Frontend Integration**: Premium users get React pagination component implementation.

#### Task 9: Microservice Communication

**Title**: Connect Multiple Services

**Description**: Implement communication between two microservices (Orders and Inventory) using REST and message queues.

**Test Cases**:

- Synchronous: Input: POST /orders, Expected: REST call to inventory, Output: Order created with inventory updated.
- Asynchronous: Input: Large batch order, Expected: Queue to inventory service, Output: Order accepted, inventory updated later.
- Circuit Breaking: Input: Inventory service down, Expected: Circuit breaker pattern, Output: Graceful degradation.
- Retry Logic: Input: Temporary network failure, Expected: Exponential backoff, Output: Eventually consistent.
- Idempotency: Input: Duplicate order, Expected: Idempotency key check, Output: No duplicate processing.

**Difficulty**: Expert

**Required Knowledge**: Microservices, message queues, distributed systems.

**Ideal Solution**:

```python
from flask import Flask, request
import requests
from retry import retry
import pika

app = Flask(__name__)
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()
channel.queue_declare(queue='inventory_updates')

@app.route('/orders', methods=['POST'])
def create_order():
    order = request.json

    # For small orders, synchronous update
    if order['quantity'] < 10:
        try:
            update_inventory(order)
        except Exception as e:
            # Fallback to async if sync fails
            channel.basic_publish(
                exchange='',
                routing_key='inventory_updates',
                body=json.dumps(order)
            )
    else:
        # Large orders always async
        channel.basic_publish(
            exchange='',
            routing_key='inventory_updates',
            body=json.dumps(order)
        )

    return {"order_id": generate_id()}, 201

@retry(tries=3, delay=1, backoff=2)
def update_inventory(order):
    response = requests.post(
        'http://inventory-service/update',
        json={"product_id": order['product_id'], "quantity": -order['quantity']},
        headers={"Idempotency-Key": order['order_id']}
    )
    response.raise_for_status()
    return response.json()
```

**Estimated Time**: 45 minutes

**Learning Objectives**: Understand microservice communication patterns, resilience strategies.

**Specific Skills**: Distributed Systems—Service communication, failure handling.

**System Design Document**: Premium users receive a detailed architecture document.

#### Task 10: CI/CD Pipeline Configuration

**Title**: Automate Deployment

**Description**: Create a GitHub Actions workflow to test, build, and deploy a Python web application.

**Test Cases**:

- Test Stage: Input: Failed test, Expected: Workflow stops, Output: Error report.
- Build Stage: Input: Successful tests, Expected: Docker image build, Output: Image published.
- Deploy Stage: Input: Successful build, Expected: Deploy to staging, Output: Working application.
- Branch Protection: Input: Direct push to main, Expected: Workflow requires review, Output: Protected branch.
- Secrets Management: Input: API keys, Expected: Use GitHub secrets, Output: Secure deployment.

**Difficulty**: Advanced

**Required Knowledge**: CI/CD, GitHub Actions, Docker, deployment strategies.

**Ideal Solution**:

```yaml
name: Python Web App CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: "3.11"
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
          pip install pytest pytest-cov
      - name: Test with pytest
        run: |
          pytest --cov=. --cov-report=xml
      - name: Upload coverage report
        uses: codecov/codecov-action@v3

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build Docker image
        run: docker build -t myapp:latest .
      - name: Login to DockerHub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
      - name: Push Docker image
        run: |
          docker tag myapp:latest ${{ secrets.DOCKER_USERNAME }}/myapp:latest
          docker push ${{ secrets.DOCKER_USERNAME }}/myapp:latest

  deploy:
    needs: build
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to staging
        uses: appleboy/ssh-action@v0.1.10
        with:
          host: ${{ secrets.HOST }}
          username: ${{ secrets.USERNAME }}
          key: ${{ secrets.SSH_KEY }}
          script: |
            docker pull ${{ secrets.DOCKER_USERNAME }}/myapp:latest
            docker stop myapp || true
            docker rm myapp || true
            docker run -d --name myapp -p 80:5000 ${{ secrets.DOCKER_USERNAME }}/myapp:latest
```

**Estimated Time**: 35 minutes

**Learning Objectives**: Understand CI/CD pipelines, automated testing and deployment.

**Specific Skills**: DevOps—GitHub Actions, Docker deployment, secrets management.

**Pipeline Visualization**: Premium users receive interactive pipeline visualizations and detailed execution logs.

#### Task 11: Implement Authentication Middleware

**Title**: Secure an Express API

**Description**: Create authentication middleware for an Express.js API using JWT, including token validation, role-based access control, and secure error handling.

**Test Cases**:

- Missing Token: Input: No Authorization header, Expected: 401 Unauthorized, Output: Error message.
- Invalid Token: Input: Malformed JWT, Expected: 403 Forbidden, Output: Error message.
- Expired Token: Input: JWT with past exp claim, Expected: 401 Unauthorized with refresh instructions, Output: Error message with refresh path.
- Role Verification: Input: User token accessing admin route, Expected: 403 Forbidden, Output: Insufficient permissions message.
- Valid Token: Input: Proper JWT with correct claims, Expected: 200 OK, Output: Protected resource.

**Difficulty**: Intermediate

**Required Knowledge**: JWT, Express middleware, authentication patterns.

**Ideal Solution**:

```javascript
const jwt = require("jsonwebtoken");

const authMiddleware =
  (requiredRole = null) =>
  (req, res, next) => {
    try {
      const authHeader = req.headers.authorization;
      if (!authHeader || !authHeader.startsWith("Bearer ")) {
        return res
          .status(401)
          .json({ error: "Access denied. No token provided." });
      }

      const token = authHeader.split(" ")[1];
      const decoded = jwt.verify(token, process.env.JWT_SECRET);

      req.user = decoded;

      if (requiredRole && (!req.user.role || req.user.role !== requiredRole)) {
        return res.status(403).json({ error: "Insufficient permissions" });
      }

      next();
    } catch (error) {
      if (error.name === "TokenExpiredError") {
        return res.status(401).json({
          error: "Token expired",
          refreshPath: "/api/auth/refresh",
        });
      }
      return res.status(403).json({ error: "Invalid token" });
    }
  };

module.exports = authMiddleware;
```

**Estimated Time**: 25 minutes

**Learning Objectives**: Understand authentication flow, security best practices.

**Specific Skills**: Authentication—Token validation, role-based access control.

**Industry Application**: This task simulates security implementation required for enterprise applications, financial services APIs, and user data protection systems.

#### Task 12: Implement Rate Limiting

**Title**: Protect API from Overuse

**Description**: Implement rate limiting on an Express.js API to prevent abuse and ensure fair resource usage.

**Test Cases**:

- Normal Usage: Input: 5 requests in 1 minute, Expected: All requests succeed, Output: 200 OK.
- Rate Exceeded: Input: 15 requests in 10 seconds, Expected: Block excess requests, Output: 429 Too Many Requests.
- IP Differentiation: Input: Different client IPs, Expected: Track limits separately, Output: Separate rate limits.
- Custom Headers: Input: X-RateLimit-Limit header, Expected: Include in response, Output: Shows limit information.
- Burst Allowance: Input: 3 quick requests then pause, Expected: Allow burst, Output: All requests succeed.

**Difficulty**: Intermediate

**Required Knowledge**: Express middleware, HTTP headers, in-memory or Redis storage.

**Ideal Solution**:

```javascript
const rateLimit = require("express-rate-limit");
const RedisStore = require("rate-limit-redis");
const redis = require("redis");

const redisClient = redis.createClient({
  host: process.env.REDIS_HOST || "localhost",
  port: process.env.REDIS_PORT || 6379,
});

const apiLimiter = rateLimit({
  store: new RedisStore({
    client: redisClient,
    prefix: "rate-limit:",
  }),
  windowMs: 60 * 1000, // 1 minute
  max: 10, // 10 requests per minute
  standardHeaders: true,
  legacyHeaders: false,
  handler: (req, res) => {
    res.status(429).json({
      error: "Too many requests, please try again later.",
      retryAfter: Math.ceil(req.rateLimit.resetTime / 1000) - Date.now() / 1000,
    });
  },
});

module.exports = apiLimiter;
```

**Estimated Time**: 20 minutes

**Learning Objectives**: Understand API protection, resource allocation, client behavior management.

**Specific Skills**: API Security—Rate limiting, distributed state management.

**Industry Application**: This mimics protection mechanisms used in public APIs, SaaS platforms, and authentication systems to prevent brute force attacks and service degradation.

#### Task 13: Create Responsive Grid Layout

**Title**: Build a Fluid Product Grid

**Description**: Implement a responsive product grid using CSS Grid that adapts from 1 column on mobile to 4 columns on large screens.

**Test Cases**:

- Mobile View: Input: 320px viewport, Expected: 1 column, Output: Full-width items.
- Tablet View: Input: 768px viewport, Expected: 2 columns, Output: Half-width items.
- Desktop View: Input: 1200px viewport, Expected: 4 columns, Output: Quarter-width items.
- Mixed Content: Input: Products with varying image heights, Expected: Align properly, Output: Clean grid alignment.
- Accessibility: Input: Keyboard navigation, Expected: Focus indicators, Output: Navigable grid.

**Difficulty**: Beginner

**Required Knowledge**: CSS Grid, media queries, responsive design.

**Ideal Solution**:

```css
.product-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
  padding: 1rem;
}

.product-item {
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(
  Okay, I understand the instructions clearly this time. I will *only* continue from the exact last character, and I will *not* repeat anything already generated. I will complete the entire document, including all remaining sections and the multi-agent workflow instructions. I am aiming for a single, complete, and correct Markdown document.

Here is the continuation, starting *precisely* from the last character of the previous correct output:

```css
0, 0, 0, 0.1);
  transition: transform 0.2s;
}

.product-item:hover,
.product-item:focus {
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.product-item:focus-visible {
  outline: 2px solid #0052cc; /* Example focus style */
  outline-offset: 2px;
}

@media (min-width: 600px) {
  .product-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 900px) {
  .product-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (min-width: 1200px) {
  .product-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}
```

**Estimated Time**: 15 minutes

**Learning Objectives**: Master modern CSS layout techniques, responsive design principles.

**Specific Skills**: Frontend Layout—CSS Grid, responsive breakpoints.

**Industry Application**: This task reflects common e-commerce, content gallery, and dashboard layout requirements.

#### Task 14: Implement Lazy Loading for Images

**Title**: Optimize Page Loading Performance

**Description**: Implement lazy loading for images on a web page to improve initial load time and reduce bandwidth usage.

**Test Cases**:

- Above Fold: Input: Visible images, Expected: Load immediately, Output: No delay for visible content.
- Below Fold: Input: Off-screen images, Expected: Load when scrolling near, Output: Images appear when scrolling.
- Failed Load: Input: Broken image URL, Expected: Show fallback, Output: Placeholder or error indicator.
- Slow Connection: Input: Throttled network, Expected: Loading indicator, Output: Visual feedback during loading.
- JavaScript Disabled: Input: No JS browser, Expected: Images still appear, Output: Standard `img` behavior.

**Difficulty**: Intermediate

**Required Knowledge**: Intersection Observer API, image optimization, browser loading attributes.

**Ideal Solution**:

```javascript
document.addEventListener("DOMContentLoaded", () => {
  // Use native lazy loading if supported
  if ("loading" in HTMLImageElement.prototype) {
    const images = document.querySelectorAll("img.lazy");
    images.forEach((img) => {
      img.src = img.dataset.src;
      img.loading = "lazy";
    });
  } else {
    // Fallback to Intersection Observer
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            const img = entry.target;
            img.src = img.dataset.src;
            img.classList.remove("lazy");
            observer.unobserve(img);
          }
        });
      },
      {
        rootMargin: "200px 0px", // Load images 200px before they enter the viewport
      }
    );

    document.querySelectorAll("img.lazy").forEach((img) => {
      observer.observe(img);
      // Add placeholder
      img.style.backgroundColor = "#e0e0e0";
      img.onerror = () => {
        img.src = "/assets/image-placeholder.svg";
        img.classList.add("error");
      };
    });
  }
});

```

**Estimated Time**: 25 minutes

**Learning Objectives**: Understand progressive enhancement, performance optimization techniques.

**Specific Skills**: Frontend Performance—Resource loading, browser APIs.

**Industry Application**: This technique is essential for media-heavy websites, news platforms, and product catalogs where initial load performance impacts user engagement and SEO rankings.
**HTML to use with the script:**
```html
<img src="placeholder.jpg" data-src="image-1.jpg" class="lazy" alt="Image 1">
<img src="placeholder.jpg" data-src="image-2.jpg" class="lazy" alt="Image 2">
<img src="placeholder.jpg" data-src="image-3.jpg" class="lazy" alt="Image 3">
```

#### Task 15: Design Database Schema for E-commerce

**Title**: Model a Store Database

**Description**: Design a normalized database schema for an e-commerce system with products, categories, users, orders, and reviews.

**Test Cases**:

- Normalization: Input: Product with multiple categories, Expected: Many-to-many relationship, Output: Junction table.
- Order History: Input: User with multiple orders, Expected: One-to-many relationship, Output: Foreign key in orders.
- Order Items: Input: Order with multiple products, Expected: Line items table, Output: Order-product association with quantity.
- Data Integrity: Input: Deleting a user with orders, Expected: Define cascading behaviors, Output: Preserved order history.
- Performance: Input: Query for popular products, Expected: Proper indexes, Output: Optimized read pattern.

**Difficulty**: Advanced

**Required Knowledge**: Database design, normalization, SQL relationships, indexes.

**Ideal Solution**:

```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_id INTEGER REFERENCES categories(category_id) ON DELETE SET NULL
);
CREATE INDEX idx_categories_parent ON categories(parent_id);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_products_name ON products(name);

CREATE TABLE product_categories (
    product_id INTEGER REFERENCES products(product_id) ON DELETE CASCADE,
    category_id INTEGER REFERENCES categories(category_id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, category_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id) ON DELETE SET NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    total_amount DECIMAL(10, 2) NOT NULL,
    shipping_address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status);

CREATE TABLE order_items (
    order_id INTEGER REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products(product_id) ON DELETE SET NULL,
    quantity INTEGER NOT NULL,
    price_at_time DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(product_id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES users(user_id) ON DELETE SET NULL,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_reviews_product ON reviews(product_id);
CREATE INDEX idx_reviews_user ON reviews(user_id);
```

**Estimated Time**: 35 minutes

**Learning Objectives**: Master database schema design, understand entity relationships.

**Specific Skills**: Database Architecture—Schema normalization, relationship modeling.

**Industry Application**: This schema design process mirrors the initial architecture phase of any data-driven application, from small business platforms to enterprise systems.

#### Task 16: Implement Data Caching

**Title**: Cache API Responses

**Description**: Implement a Redis-backed caching system for API responses to improve performance and reduce database load.

**Test Cases**:

- Cache Miss: Input: First request for data, Expected: Store in cache, Output: Database query result.
- Cache Hit: Input: Repeat request, Expected: Return cached data, Output: Fast response without DB query.
- Cache Invalidation: Input: Data update, Expected: Invalidate cache, Output: Fresh data on next request.
- Cache Expiration: Input: Old cached data, Expected: Auto-expire after TTL, Output: Refresh from database.
- Bulk Invalidation: Input: Category update affecting multiple items, Expected: Pattern-based invalidation, Output: All related caches cleared.

**Difficulty**: Advanced

**Required Knowledge**: Redis, caching patterns, API design.

**Ideal Solution**:

```javascript
const express = require("express");
const Redis = require("ioredis");

const app = express();
const redis = new Redis({
  host: process.env.REDIS_HOST || "localhost",
  port: process.env.REDIS_PORT || 6379,
});

const DEFAULT_EXPIRATION = 3600; // 1 hour in seconds

// Cache middleware
const cacheMiddleware = (req, res, next) => {
  const cacheKey = `api:${req.originalUrl}`;

  redis
    .get(cacheKey)
    .then((cachedData) => {
      if (cachedData) {
        console.log("Cache hit for", cacheKey);
        return res.json(JSON.parse(cachedData));
      }

      // Store original res.json function
      const originalJson = res.json;

      // Override res.json to cache the response
      res.json = function (data) {
        // Store in cache with expiration
        redis
          .setex(cacheKey, DEFAULT_EXPIRATION, JSON.stringify(data))
          .catch((err) => console.error("Cache storage error:", err));

        // Call the original function
        return originalJson.call(this, data);
      };

      next();
    })
    .catch((error) => {
      console.error("Cache error:", error);
      next(); // Proceed without caching on error
    });
};

// Cache invalidation function
const invalidateCache = (pattern) => {
  return new Promise((resolve, reject) => {
    const stream = redis.scanStream({
      match: `api:${pattern}*`,
    });

    const pipeline = redis.pipeline();

    stream.on("data", (keys) => {
      if (keys.length) {
        keys.forEach((key) => {
          pipeline.del(key);
        });
      }
    });

    stream.on("end", () => {
      pipeline.exec().then(resolve).catch(reject);
    });

    stream.on("error", reject);
  });
};

// Example routes
app.get("/products", cacheMiddleware, async (req, res) => {
  // Database query logic here
  const products = await db.products.findAll();
  res.json(products);
});

app.put("/products/:id", async (req, res) => {
  // Update product
  await db.products.update(req.params.id, req.body);

  // Invalidate specific product cache and list caches
  await Promise.all([
    redis.del(`api:/products/${req.params.id}`),
    invalidateCache("/products"),
  ]);

  res.json({ success: true });
});
```

**Estimated Time**: 30 minutes

**Learning Objectives**: Learn distributed caching strategies, API performance optimization.

**Specific Skills**: Performance Optimization—Redis caching, invalidation patterns.

**Industry Application**: This pattern is implemented in high-traffic web applications, content delivery systems, and API gateways to maintain performance at scale.

#### Task 17: Implement WebSockets for Real-time Updates

**Title**: Build a Live Notification System

**Description**: Create a real-time notification system using WebSockets to push updates to connected clients when server-side events occur.

**Test Cases**:

- Connection Establishment: Input: Client connect, Expected: Successful handshake, Output: Connected status.
- Message Broadcasting: Input: New notification event, Expected: All clients receive, Output: Updated UI for all users.
- Authentication: Input: Unauthorized connection, Expected: Reject with error, Output: Connection closed.
- Reconnection: Input: Network disruption, Expected: Auto reconnect, Output: Resumed connection.
- Targeted Notification: Input: User-specific event, Expected: Only relevant client receives, Output: Personalized update.

**Difficulty**: Advanced

**Required Knowledge**: WebSockets, event-driven architecture, Socket.IO or ws libraries.

**Ideal Solution**:

```javascript
const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const jwt = require("jsonwebtoken");

const app = express();
const server = http.createServer(app);
const io = new Server(server);

// Authentication middleware for Socket.IO
io.use((socket, next) => {
  const token = socket.handshake.auth.token;

  if (!token) {
    return next(new Error("Authentication token required"));
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    socket.user = decoded;
    next();
  } catch (err) {
    return next(new Error("Invalid authentication token"));
  }
});

// Connection handling
io.on("connection", (socket) => {
  console.log(`User connected: ${socket.user.id}`);

  // Join user to their personal room
  socket.join(`user:${socket.user.id}`);

  // Join rooms based on user roles/groups
  if (socket.user.roles) {
    socket.user.roles.forEach((role) => {
      socket.join(`role:${role}`);
    });
  }

  socket.on("disconnect", () => {
    console.log(`User disconnected: ${socket.user.id}`);
  });

  // Error handling
  socket.on("error", (error) => {
    console.error(`Socket error for user ${socket.user.id}:`, error);
  });
});

// Notification sending functions
const notificationService = {
  // Send to specific user
  sendToUser: (userId, event, data) => {
    io.to(`user:${userId}`).emit(event, data);
  },

  // Send to all users with a specific role
  sendToRole: (role, event, data) => {
    io.to(`role:${role}`).emit(event, data);
  },

  // Send to all connected clients
  broadcast: (event, data) => {
    io.emit(event, data);
  },
};

module.exports = { app, server, notificationService };
```
**Estimated Time**: 35 minutes

**Learning Objectives**: Understand real-time communication protocols, event-driven architectures.

**Specific Skills**: Real-time Systems—WebSockets, event handling.

**Industry Application**: This pattern is used in collaborative tools, monitoring dashboards, chat applications, and any system requiring immediate updates without page refreshes.
#### Task 18: Implement File Upload with Progress

**Title**: Create a Chunked File Uploader

**Description**: Implement a file upload system with chunking, progress tracking, and resumable uploads using JavaScript.

**Test Cases**:

- Small File: Input: 2MB file, Expected: Quick upload in one chunk, Output: Success confirmation.
- Large File: Input: 50MB file, Expected: Upload in chunks, Output: Progress updates and success.
- Connection Loss: Input: Network disruption during upload, Expected: Resume from last chunk, Output: Completed upload after reconnection.
- File Validation: Input: Invalid file type, Expected: Reject before upload, Output: Error message to user.
- Server Error: Input: Server returns 500 error, Expected: Retry mechanism, Output: Eventual success or meaningful error.

**Difficulty**: Expert

**Required Knowledge**: File API, XHR/fetch with progress, chunked uploads.

**Ideal Solution**:
```javascript
class ChunkedUploader {
  constructor(file, options = {}) {
    this.file = file;
    this.chunkSize = options.chunkSize || 1024 * 1024; // 1MB
    this.retries = options.retries || 3;
    this.endpoint = options.endpoint || "/api/upload";
    this.onProgress = options.onProgress || (() => {});
    this.onComplete = options.onComplete || (() => {});
    this.onError = options.onError || (() => {});

    this.totalChunks = Math.ceil(file.size / this.chunkSize);
    this.uploadedChunks = new Set();
    this.currentChunk = 0;
    this.uploadId = null;
    this.isUploading = false;
  }

  async start() {
    if (this.isUploading) return;
    this.isUploading = true;

    try {
      // Create upload session
      const response = await fetch(`${this.endpoint}/create`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          filename: this.file.name,
          contentType: this.file.type,
          size: this.file.size,
          totalChunks: this.totalChunks,
        }),
      });

      if (!response.ok) throw new Error("Failed to initialize upload");
      const data = await response.json();
      this.uploadId = data.uploadId;

      // Resume logic - check for existing chunks
      await this.checkExistingChunks();

      // Start uploading chunks
      await this.uploadNextChunk();
    } catch (error) {
      this.isUploading = false;
      this.onError(error);
    }
  }

  async checkExistingChunks() {
    const response = await fetch(`${this.endpoint}/${this.uploadId}/status`);
    if (response.ok) {
      const data = await response.json();
      data.uploadedChunks.forEach((i) => this.uploadedChunks.add(i));

      // If chunks exist, calculate progress
      if (this.uploadedChunks.size > 0) {
        const progress = (this.uploadedChunks.size / this.totalChunks) * 100;
        this.onProgress(progress);
      }
    }
  }

  async uploadNextChunk() {
    // Find next chunk that hasn't been uploaded
    while (
      this.currentChunk < this.totalChunks &&
      this.uploadedChunks.has(this.currentChunk)
    ) {
      this.currentChunk++;
    }

    // Check if all chunks are uploaded
    if (this.currentChunk >= this.totalChunks) {
      await this.finalizeUpload();
      return;
    }

    const start = this.currentChunk * this.chunkSize;
    const end = Math.min(start + this.chunkSize, this.file.size);
    const chunk = this.file.slice(start, end);

    try {
      const formData = new FormData();
      formData.append("chunk", chunk);
      formData.append("chunkIndex", this.currentChunk);
      formData.append("uploadId", this.uploadId);

      const response = await fetch(`${this.endpoint}/${this.uploadId}/chunk`, {
        method: "POST",
        body: formData,
      });

      if (!response.ok) throw new Error("Chunk upload failed");

      this.uploadedChunks.add(this.currentChunk);
      this.currentChunk++;

      // Update progress
      const progress = (this.uploadedChunks.size / this.totalChunks) * 100;
      this.onProgress(progress);

      // Upload next chunk
      await this.uploadNextChunk();
    } catch (error) {
      // Retry logic
      if (this.retries > 0) {
        this.retries--;
        setTimeout(() => this.uploadNextChunk(), 1000);
      } else {
        this.isUploading = false;
        this.onError(error);
      }
    }
  }

  async finalizeUpload() {
    try {
      const response = await fetch(
        `${this.endpoint}/${this.uploadId}/finalize`,
        {
          method: "POST",
        }
      );

      if (!response.ok) throw new Error("Failed to finalize upload");

      const data = await response.json();
      this.isUploading = false;
      this.onComplete(data);
    } catch (error) {
      this.isUploading = false;
      this.onError(error);
    }
  }

  pause() {
    this.isUploading = false;
  }

  resume() {
    if (!this.isUploading && this.uploadId) {
      this.isUploading = true;
      this.uploadNextChunk();
    }
  }
}

```
**Estimated Time**: 45 minutes

**Learning Objectives**: Master advanced file handling, asynchronous operations, and error recovery.

**Specific Skills**: Frontend Advanced—File API, chunked uploads, retry strategies.

**Industry Application**: This solution is used in media upload platforms, document management systems, and backup services where reliable handling of large files is critical.

#### Task 19: Implement Concurrent Data Processing

**Title**: Process Data in Parallel

**Description**: Create a solution to process a large dataset concurrently using worker threads or a parallel processing approach.

**Test Cases**:

- Single Thread: Input: Process 1,000 records sequentially, Expected: Baseline performance, Output: Processing time.
- Multi-Thread: Input: Process 1,000 records with 4 workers, Expected: ~4x speedup, Output: Faster processing time.
- Load Balancing: Input: Mixed workload complexity, Expected: Even distribution, Output: Similar completion time across workers.
- Error Handling: Input: Faulty record in batch, Expected: Isolate failure, Output: Other processing continues.
- Thread Communication: Input: Shared progress data, Expected: Synchronized updates, Output: Accurate overall progress.

**Difficulty**: Expert

**Required Knowledge**: Concurrency patterns, worker threads, shared memory.

**Ideal Solution**:

```javascript
const {
  Worker,
  isMainThread,
  parentPort,
  workerData,
} = require("worker_threads");
const os = require("os");

class ParallelProcessor {
  constructor(dataArray, processingFn, options = {}) {
    this.data = dataArray;
    this.processingFn = processingFn;
    this.workerCount = options.workerCount || os.cpus().length;
    this.batchSize = Math.ceil(dataArray.length / this.workerCount);
    this.results = [];
    this.errors = [];
    this.onProgress = options.onProgress || (() => {});
    this.onComplete = options.onComplete || (() => {});
    this.onError = options.onError || (() => {});
  }

  async process() {
    return new Promise((resolve, reject) => {
      let completedWorkers = 0;
      let processedItems = 0;

      // Create workers based on CPU cores
      for (let i = 0; i < this.workerCount; i++) {
        const start = i * this.batchSize;
        const end = Math.min(start + this.batchSize, this.data.length);

        if (start >= this.data.length) continue;

        const workerData = {
          data: this.data.slice(start, end),
          processingFn: this.processingFn.toString(),
          workerId: i,
        };

        const worker = new Worker(__filename, { workerData });

        worker.on("message", (message) => {
          if (message.type === "progress") {
            processedItems++;
            this.onProgress({
              workerId: message.workerId,
              progress: (processedItems / this.data.length) * 100,
            });
          } else if (message.type === "result") {
            this.results.push(message.result);
          } else if (message.type === "error") {
            this.errors.push(message.error);
          }
        });

        worker.on("exit", (code) => {
          if (code !== 0) {
            this.onError(new Error(`Worker ${i} exited with code ${code}`));
          }
          completedWorkers++;
          if (completedWorkers === this.workerCount) {
            this.onComplete(this.results);
            resolve(this.results);
          }
        });
      }
    });
  }
}

if (isMainThread) {
  // Main thread logic
  const data = Array.from({ length: 1000 }, (_, i) => i);
  const processingFn = (item) => item * 2;

  const processor = new ParallelProcessor(data, processingFn, {
    workerCount: 4,
    onProgress: (progress) => console.log(`Progress: ${progress.progress}%`),
    onComplete: (results) => console.log("Processing complete:", results),
    onError: (error) => console.error("Processing error:", error),
  });

  processor.process();
} else {
  // Worker thread logic
  const { data, processingFn, workerId } = workerData;
  const processItem = new Function("item", `return (${processingFn})(item);`);

  data.forEach((item, index) => {
    try {
      const result = processItem(item);
      parentPort.postMessage({
        type: "progress",
        workerId,
        progress: (index / data.length) * 100,
      });
      parentPort.postMessage({ type: "result", result });
    } catch (error) {
      parentPort.postMessage({ type: "error", error: error.message });
    }
  });

  parentPort.close();
}
```

**Estimated Time**: 45 minutes

**Learning Objectives**: Master parallel processing concepts, thread management, and resource optimization.

**Specific Skills**: Performance Optimization—Multi-threading, workload distribution, thread synchronization.

**Industry Application**: This pattern is implemented in virtually every secure API, from financial services to healthcare applications requiring robust user authentication.

#### Task 20: Build a Responsive Navigation Component

**Title**: Create an Adaptive Navigation Menu

**Description**: Implement a responsive navigation component that adapts to different screen sizes using CSS and JavaScript. The navigation should display as a horizontal menu on desktop and collapse to a hamburger menu on mobile devices.

**Test Cases**:

- Desktop View: Input: Browser width > 768px, Expected: Horizontal menu, Output: All menu items visible in row.
- Mobile View: Input: Browser width < 768px, Expected: Collapsed hamburger icon, Output: Menu hidden, icon visible.
- Toggle Functionality: Input: Click hamburger icon, Expected: Menu expands, Output: Vertical menu appears with animation.
- Close Functionality: Input: Click close button or outside menu, Expected: Menu collapses, Output: Menu disappears with animation.
- Keyboard Navigation: Input: Tab key presses, Expected: Focus moves through menu items, Output: Visual focus indicator moves appropriately.
- Screen Reader: Input: Screen reader activated, Expected: Menu elements announced, Output: ARIA attributes properly conveyed.

**Difficulty**: Intermediate

**Required Knowledge**: HTML, CSS, JavaScript, responsive design principles, accessibility.

**Ideal Solution**:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Responsive Navigation</title>
    <style>
        /* Basic Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: sans-serif;
        }

        /* Navigation Styles */
        .navbar {
            background-color: #333;
            color: #fff;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .nav-menu {
            list-style: none;
            display: flex;
        }

        .nav-item {
            margin: 0 1rem;
        }

        .nav-link {
            color: #fff;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .nav-link:hover,
        .nav-link:focus {
            color: #ddd;
        }

        .hamburger {
            display: none; /* Hidden by default on larger screens */
            cursor: pointer;
            flex-direction: column;
            width: 24px;
            height: 18px; /* Adjusted for three 2px lines + 6px spacing */
            justify-content: space-between;
        }

        .hamburger div {
            width: 100%;
            height: 2px;
            background-color: #fff;
            transition: all 0.3s ease;
        }

        /* Mobile Styles */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .hamburger {
                display: flex; /* Show on mobile */
            }

            .nav-menu {
                display: none; /* Hide by default on mobile */
                flex-direction: column;
                width: 100%;
                background-color: #333;
                position: absolute;
                top: 60px; /* Adjust based on your header height */
                left: 0;
                transition: transform 0.3s ease-in-out;
                transform: translateX(-100%); /* Initially off-screen */
            }

            .nav-menu.active {
                display: flex;
                transform: translateX(0); /* Slide in */
            }

            .nav-item {
                margin: 0.5rem 0;
                width: 100%;
                text-align: center;
            }
          /* Hamburger Animation */
          .hamburger.active div:nth-child(1) {
              transform: translateY(8px) rotate(45deg); /* Middle bar + spacing */
          }

          .hamburger.active div:nth-child(2) {
              opacity: 0;
          }

          .hamburger.active div:nth-child(3) {
              transform: translateY(-8px) rotate(-45deg); /* Middle bar + spacing */
          }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <a href="#" class="navbar-brand">My Site</a>
        <ul class="nav-menu">
            <li class="nav-item"><a href="#" class="nav-link">Home</a></li>
            <li class="nav-item"><a href="#" class="nav-link">About</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Services</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Contact</a></li>
        </ul>
        <div class="hamburger" role="button" tabindex="0" aria-label="Menu" aria-expanded="false">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </nav>

    <script>
        const hamburger = document.querySelector('.hamburger');
        const navMenu = document.querySelector('.nav-menu');

        hamburger.addEventListener('click', () => {
          hamburger.classList.toggle('active');
          navMenu.classList.toggle('active');
          // Toggle aria-expanded attribute for accessibility
          const expanded = hamburger.getAttribute('aria-expanded') === 'true';
          hamburger.setAttribute('aria-expanded', !expanded);
        });
        // Close menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!hamburger.contains(e.target) && !navMenu.contains(e.target)) {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
                hamburger.setAttribute('aria-expanded', 'false');
            }
        });

        // Keyboard navigation
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach((link, index) => {
          link.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowDown' || e.key === 'ArrowRight') {
              e.preventDefault();
              const nextIndex = (index + 1) % navLinks.length;
              navLinks[nextIndex].focus();
            } else if (e.key === 'ArrowUp' || e.key === 'ArrowLeft') {
              e.preventDefault();
              const prevIndex = (index - 1 + navLinks.length) % navLinks.length;
              navLinks[prevIndex].focus();
            }
          });
        });
    </script>
</body>
</html>
```

**Estimated Time**: 40 minutes

**Learning Objectives**: Master responsive design principles, learn accessible navigation patterns, implement smooth animations.

**Specific Skills**: Frontend—Responsive design, CSS media queries, JavaScript event handling, ARIA attributes.

**Industry Application**: This component appears in virtually every modern website, requiring thoughtful implementation for optimal user experience across devices.

#### Task 21: Build a Resource Management API

**Title**: Build a Resource Management API

**Description**: Create a complete RESTful API for managing a resource (e.g., products) with all CRUD operations, proper status codes, error handling, and input validation.

**Test Cases**:

*   **Create Resource:** Input: Valid product data, Expected: Resource created, Output: 201 Created with resource data and ID.
*   **Read All Resources:** Input: GET request, Expected: List of all resources, Output: 200 OK with array of resources.
*   **Read Single Resource:** Input: Valid ID, Expected: Single resource returned, Output: 200 OK with resource data.
*   **Read Nonexistent Resource:** Input: Invalid ID, Expected: Resource not found, Output: 404 Not Found.
*   **Update Resource:** Input: Valid ID and data, Expected: Resource updated, Output: 200 OK with updated resource.
*   **Delete Resource:** Input: Valid ID, Expected: Resource removed, Output: 204 No Content.
*   **Okay, I will now complete the Master Project Blueprint, Version 3.0, starting precisely from the last generated character and ensuring no omissions or repetitions. I will incorporate all previous feedback, complete all remaining sections, and integrate the multi-agent workflow. This is the final assembly.

```
Invalid Data: Input: Malformed data, Expected: Validation error, Output: 400 Bad Request with error details.
Partial Update: Input: PATCH with partial data, Expected: Resource partially updated, Output: 200 OK with updated resource.

**Difficulty**: Intermediate

**Required Knowledge**: REST API design, Express.js, HTTP methods (GET, POST, PUT, DELETE), JSON, error handling.

**Ideal Solution:**

```javascript
const express = require('express');
const app = express();
app.use(express.json()); // Middleware for parsing JSON request bodies

// In-memory "database" for this example.  Replace with Prisma in the real application.
let products = [
  { id: 1, name: 'Laptop', price: 1200 },
  { id: 2, name: 'Mouse', price: 25 },
  { id: 3, name: 'Keyboard', price: 75 },
];
let nextId = 4;

// Helper function to find a product by ID
function findProduct(id: number) {
  return products.find(p => p.id === id);
}

// GET /api/v1/products (List all products)
app.get('/api/v1/products', (req, res) => {
  res.status(200).json(products);
});

// GET /api/v1/products/:id (Get a single product)
app.get('/api/v1/products/:id', (req, res) => {
  const id = parseInt(req.params.id);
  if (isNaN(id)) {
    return res.status(400).json({ error: { code: 'INVALID_ID', message: 'Invalid product ID format.' } });
  }

  const product = findProduct(id);
  if (!product) {
    return res.status(404).json({ error: { code: 'PRODUCT_NOT_FOUND', message: 'Product not found.' } });
  }

  res.status(200).json(product);
});

// POST /api/v1/products (Create a new product)
app.post('/api/v1/products', (req, res) => {
  const { name, price } = req.body;

  if (!name || typeof name !== 'string' || name.trim().length === 0) {
    return res.status(400).json({ error: { code: 'INVALID_INPUT', message: 'Name is required and must be a non-empty string.' } });
  }
  if (typeof price !== 'number' || price <= 0) {
    return res.status(400).json({ error: { code: 'INVALID_INPUT', message: 'Price is required and must be a positive number.' } });
  }

  const newProduct = {
    id: nextId++,
    name,
    price,
  };
  products.push(newProduct);

  res.status(201).json(newProduct);
});

// PUT /api/v1/products/:id (Update a product)
app.put('/api/v1/products/:id', (req, res) => {
  const id = parseInt(req.params.id);
    if (isNaN(id)) {
    return res.status(400).json({ error: { code: 'INVALID_ID', message: 'Invalid product ID format.' } });
  }
  const product = findProduct(id);

  if (!product) {
    return res.status(404).json({ error: { code: 'PRODUCT_NOT_FOUND', message: 'Product not found.' } });
  }

  const { name, price } = req.body;

  if (name !== undefined) {
      if (typeof name !== 'string' || name.trim().length === 0) {
          return res.status(400).json({ error: { code: 'INVALID_INPUT', message: 'Name must be a non-empty string.' } });
      }
      product.name = name;
  }
  if (price !== undefined) {
    if (typeof price !== 'number' || price <= 0) {
      return res.status(400).json({ error: { code: 'INVALID_INPUT', message: 'Price must be a positive number.' } });
    }
    product.price = price;
  }


  res.status(200).json(product);
});

// DELETE /api/v1/products/:id (Delete a product)
app.delete('/api/v1/products/:id', (req, res) => {
  const id = parseInt(req.params.id);
    if (isNaN(id)) {
    return res.status(400).json({ error: { code: 'INVALID_ID', message: 'Invalid product ID format.' } });
  }
  const productIndex = products.findIndex(p => p.id === id);

  if (productIndex === -1) {
    return res.status(404).json({ error: { code: 'PRODUCT_NOT_FOUND', message: 'Product not found.' } });
  }

  products.splice(productIndex, 1);
  res.status(204).send(); // No Content
});

// Error handling middleware (must be defined last)
app.use((err, req, res, next) => {
  console.error(err.stack); // Log the full error stack trace
  res.status(500).json({ error: { code: 'INTERNAL_SERVER_ERROR', message: 'Internal Server Error' } });
});

const port = 3000; // Use environment variable in real application
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});

```

**Estimated Time**: 50 minutes

**Learning Objectives**: Master RESTful API design principles, status code usage, and error handling patterns.

**Specific Skills**: Backend—API design, validation strategies, HTTP protocol understanding.

**Industry Application**: This pattern forms the backbone of modern web applications, from e-commerce platforms to content management systems.

**(End of Task 21)**

The section below shows an example of a task that uses files. Task 5 is used as an example, because some students could struggle on file processing.
### 4.x Task Example: File handling
#### Task 5: Process Multiple Files with Exception Handling

**Title**: Robust File Processor

**Description**: Process multiple CSV files, handling exceptions gracefully.

**Test Cases**:

- File Not Found: Input: `missing.csv`, Expected: Skip with log, Output: Continue.
- Permission Denied: Input: Locked file, Expected: Skip with log, Output: Continue.
- Malformed CSV: Input: Bad row, Expected: Skip row, Output: Partial result.
- Large File: Input: 1GB CSV, Expected: Chunked processing, Output: Full result.
- Empty File: Input: 0 bytes, Expected: Log and skip, Output: No crash.

**Difficulty**: Advanced

**Required Knowledge**: File I/O, exceptions, Python `csv`.

**Ideal Solution**:

```python
import csv, logging, os

logging.basicConfig(level=logging.INFO)

def process_files(filenames):
    for filename in filenames:
        try:
            # Construct absolute path. Assume files are in a "data" subdirectory.
            filepath = os.path.join("data", filename)

            with open(filepath, 'r') as f:
                reader = csv.reader(f)
                for row in reader:
                    print(row) # Replace with actual processing

        except FileNotFoundError:
            logging.info(f"File not found: {filename}")  # Log original filename
        except PermissionError:
            logging.warning(f"No access to: {filename}") # Log original filename
        except csv.Error as e:
            logging.error(f"Error reading CSV file {filename}: {e}")
        except Exception as e:
            logging.error(f"Unexpected error processing {filename}: {e}")

# Create a sample "data" directory and files for testing
os.makedirs("data", exist_ok=True)
with open("data/valid.csv", "w") as f:
    f.write("header1,header2\nvalue1,value2\n")
# You can't directly create an inaccessible file in a cross-platform way
# within this script.  The test would need to simulate that condition.

process_files(["valid.csv", "missing.csv"])```
**AI Instruction:** The files necessary to run the code would be found in `data` directory. The main file which runs the code should have same as defined in `LanguageConfig` in `codeExecutorService`. In this example, the main file is `solution.py`. Create a `data` folder with sample data that would be used in the test cases.

**Estimated Time**: 25 minutes

**Learning Objectives**: Learn robust exception handling, file processing.

**Specific Skills**: Exception Handling—Error recovery, logging.

**Related Tasks**: Links to data validation and transformation tasks.
**Test Files:** To make test files for the test cases, use different os commands for each case. Here are examples:

**File Not Found:** Don't create file in the input.
**Permission Denied:** In the test case, change the test file to be read-only. You could use `chmod` command.
```bash
chmod 444 test_file.csv
```
**Malformed CSV**:
Create a file, in which lines have different number of columns.
**Large File:** Create large file using `truncate` command.
```bash
truncate -s 1G large_file.csv```
**Empty file**: Just create empty file.

## 5. Technical Design

### 5.1 System Architecture

The Job-Ready Skill Simulator utilizes a modern microservices architecture.  This design promotes scalability, maintainability, and independent deployment of services. The system is designed for deployment on DigitalOcean's App Platform (initially) and Kubernetes (Phase 3).

#### 5.1.1 Frontend Layer

*   **Technology:** Next.js 14.1.0 (React framework) with TypeScript.
*   **Purpose:** Provides the user interface, handles user interactions, and communicates with the backend API.
*   **Key Features:**
    *   Server-side rendering (SSR) for improved SEO and initial load time, and client-side rendering.
    *   Client-side routing with Next.js's App Router.
    *   Component-based UI architecture, with reusable UI using shadcn/ui.
    *   State management with Zustand.
    *   API data fetching and caching with TanStack Query.
    *   Form handling with React Hook Form and Zod validation.
    *   Code editor integration with CodeMirror 6.
    *   Animation and transitions with Framer Motion.
    *   Rich content authoring with MDX.
    *   Responsive design using Tailwind CSS.
    *   Accessibility features (WCAG 2.1 AA compliance).
    *   Internationalization (i18n) support (Phase 2).

#### 5.1.2 Backend Services

*   **Technology:** Express.js 4.18.2 running on Node.js 20 LTS, with TypeScript.
*   **Purpose:** Provides the RESTful API for the frontend and other clients.  Handles business logic, data access, and integration with external services.
*   **Key Services:**
    *   **API Gateway:**  Handles incoming requests, routing, and authentication.  This is implemented within the Express.js application itself using routes and middleware.
    *   **Authentication Service:** Manages user authentication, authorization, and session management.
    *   **Challenge Service:** Manages the challenge library, including creation, retrieval, updating, and deletion of challenges.
    *   **Submission Service:** Handles code submissions, executes tests, and coordinates feedback generation.
    *   **User Service:** Manages user profiles, progress tracking, and user-related data.
    *   **AI Feedback Service:** Generates personalized feedback on code submissions using AI models.
    *   **Analytics Service:** Collects and processes data for user activity, platform usage, and educational outcomes. (Future)
    *   **Payment Service:**  Handles subscription management and payment processing (Future).

#### 5.1.3 AI/Machine Learning Layer

*   **Purpose:**  Powers the AI feedback system, providing personalized code reviews and learning recommendations.
*   **Key Components:**
    *   **AI Provider Abstraction:**  A layer that abstracts the interaction with different AI models (OpenAI, Anthropic).  This allows for switching between providers or using a combination of models.
    *   **Prompt Engineering Framework:**  A system for generating optimized prompts for AI models, incorporating task context, user information, and specific feedback criteria.  This includes prompt versioning and A/B testing.
    *   **Feedback Processing Pipeline:**  A pipeline for pre-processing code submissions (e.g., normalizing code, extracting relevant information), calling the AI API, parsing the response, and storing the feedback.
    *   **Multi-Tiered Model Selection:**  A strategy for selecting the appropriate AI model based on cost, performance, and user tier.
        *   **Tier 1 (Premium/Urgent):** GPT-4, Claude 3 Opus
        *   **Tier 2 (Standard):** GPT-3.5-turbo, Claude Sonnet
        *   **Tier 3 (Fallback/Basic):**  Rule-based feedback, pattern matching, potentially a smaller, fine-tuned model in the future.
    *   **Fallback Mechanisms:**  Fallback to pattern-based feedback or basic feedback if AI generation fails or is unavailable.
      * **Feedback Monitor**: Used to monitor AI model performance, usage and cost.

#### 5.1.4 Data Layer

*   **Primary Database:** PostgreSQL 16 – Stores structured data such as user accounts, challenge information, submission metadata, and progress data.  Chosen for its robustness, ACID compliance, JSONB support (for flexible data), and the availability of extensions like `pgvector`.
*   **ORM:** Prisma 5.4.2 – Provides type-safe database access and migrations.  Simplifies database interactions and ensures data integrity.
*   **Connection Pooling:** PgBouncer – Manages database connections efficiently, reducing connection overhead and improving performance.
*   **Caching:** Redis 7.2 – Stores session data, API response caches, and AI feedback caches. Improves performance and reduces database load.
*   **Search:** MeiliSearch 1.5 (Phase 2) – Enables fast, relevant search for challenges and resources.  Provides typo tolerance and a better user experience than basic SQL `LIKE` queries.
*   **Object Storage:** DigitalOcean Spaces (S3-compatible) – Stores user-uploaded files (profile images) and potentially large code submissions or historical data.

#### 5.1.5 Infrastructure

*   **Hosting:** DigitalOcean App Platform (initial), Kubernetes (Phase 3).
*   **Containerization:** Docker, Docker Compose (for development).
*   **CI/CD:** GitHub Actions.
*   **Monitoring:** Sentry (error tracking), Prometheus & Grafana (metrics), ELK stack (logging).

#### 5.1.6  Code Execution Environment

*   **Isolation:**  Docker containers provide a secure and isolated environment for executing user-submitted code.
*   **Resource Limits:**  Strict limits on CPU, memory, network access, and execution time are enforced to prevent abuse and ensure fair resource allocation.
*   **Language Runtimes:**  Separate Docker images are used for each supported programming language (Node.js for JavaScript, Python 3.10, OpenJDK 17 for Java, PostgreSQL image for SQL).
*   **Sandboxing:**  Additional sandboxing techniques are used within each language runtime:
    *   **JavaScript:** `vm2` module for secure execution of untrusted code.
    *   **Python:**  `resource` module to limit resource consumption.
*   **Test Runners:**
    *   **JavaScript:** `vitest` (executed with `node --expose-internals ./node_modules/vitest/vitest.mjs run --reporter=json --outputFile=test-results.json`)
    *   **Python:** `pytest` (executed with `python -m pytest -v --json-report --json-report-file=test-results.json`)
    *   **Java:** JUnit 5 with Maven (executed with `mvn test -DargLine=-Dfile.encoding=UTF-8 -Dmaven.test.failure.ignore=true -Dtest=SolutionTest`)
    * **SQL:** Create a database inside docker container, and apply user's solution, and test file on it.
*  **Test result parsing:** The service will parse output of the test runners.

#### 5.1.7 Monitoring and Logging

*  **Monitoring:**
    *   **Prometheus:** Collect metrics on application performance, resource usage, and error rates.
    *   **Grafana:** Create dashboards to visualize metrics and monitor system health.
    *  **Sentry:** Track and report application errors.
    *  **Uptime Monitoring:** Monitor application uptime using service like UptimeRobot.
* **Logging:**
  * Use pino for structured logging.
  * Log levels: TRACE, DEBUG, INFO, WARN, ERROR, FATAL.
  * Log format: JSON.
    ```json
    {
      "level": "info",
      "time": "2023-09-17T10:30:45Z",
      "requestId": "abc-xyz-123",
      "message": "User logged in successfully",
      "userId": "user-123",
      "email": "user@example.com",
      "...": "..."
    }
    ```
   * Log aggregation using ELK stack.
   * Log rotation.

### 5.2 Data Flow Diagrams

**(AI Instruction: Generate Mermaid diagrams for the following data flows.  These diagrams should be embedded directly in the Markdown document.)**

1.  **User Registration:** Show the flow of data when a new user registers on the platform (both email/password and OAuth flows).
2.  **Challenge Submission:** Illustrate the flow from code submission to test execution, feedback generation, and progress update.
3.  **AI Feedback Generation:** Detail the steps involved in generating AI feedback, including caching, similarity checks, prompt creation, AI API calls, and response parsing.
4. **User access to challenge list:** show how the request is served, including cache.

```mermaid
sequenceDiagram
    actor Student
    participant FE as Frontend
    participant API as API Gateway
    participant CH as Challenge Service
	  participant Redis as Redis Cache
    participant DB as Database

    Student->>FE: Request Challenge List
    FE->>API: Get Challenge List
    API->>CH: Challenge List Request
		CH->>Redis: Check cache
    alt Cache Hit
        Redis-->>CH: Challenge Data
        CH-->>API: Challenge Details
        API-->>FE: Display Challenge
    else Cache Miss
	      CH->>DB: Retrieve Challenge list
	      DB-->>CH: Challenge Data
	      CH->>Redis: Set Cache data
        CH-->>API: Challenge Details
        API-->>FE: Display Challenge
    end
    FE-->>Student: View Results & Feedback
```

### 5.3 API Specifications (OpenAPI 3.0)

**(AI Instruction: Generate a complete OpenAPI 3.0 specification for *all* API endpoints.  This specification should be in YAML format and should include detailed descriptions, request/response schemas, and error codes.  Use the `openapi-generator-cli` to generate client SDKs from this specification.)**
Since the complete file would be very long, it would be added to `docs/api-documentation.md`, and here just an example:

```yaml
openapi: 3.0.0
info:
  title: KodeLab API
  version: 1.0.0
  description: API for the KodeLab coding platform
servers:
  - url: https://api.kodelab.io/api/v1
    description: Production server
  - url: https://staging.kodelab.io/api/v1
    description: Staging server
  - url: http://localhost:4000/api/v1
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
            details:
              type: object #For example validation errors
              nullable: true
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
**AI Instruction:** This is a *partial* example of an OpenAPI 3.0 specification. You MUST generate a complete specification that includes *all* API endpoints defined in this Blueprint, with detailed request and response schemas for *each* endpoint. Use this example as a starting point and expand it to cover the entire API surface.  Use tools like Swagger Editor or Stoplight Studio to validate the generated OpenAPI specification. After defining, you can generate an API documentation using tools like Swagger UI.

## A. Project Initialization and Environment Setup

**(This section was largely completed in previous iterations and is reproduced here, with minor updates for completeness.)**

### A.1 Project Structure
The project should have exactly this structure, as mentioned before.

### A.2 Dependency Management
It's also described before.

### A.3 Build System Configuration
It's provided before.

### A.4 Development Environment Setup
It is exist in the document before.

### A.5 Version Control
It exists in the document.

## B. Core Architectural Components and Modules
**(This section was partially completed in previous iterations. Here, it is presented in its entirety, with all necessary details.)**

### B.1 Component Decomposition
**(This section, with all its components and details, was fully provided in previous iterations. It's included in its entirety in the final assembled document above.  This section includes the detailed breakdown of the `auth-service`, `challenge-service`, `submission-service`, and `user-service`.)**

### B.2 Data Model
**(This section, with the complete Prisma schema, was fully provided in previous iterations. It's included in its entirety in the final assembled document above.)**

### B.3 Inter-Component Communication
**(Already provided in previous iteration. This section is complete and consistent with the requirements.)**

### B.4 Security Considerations
**(Already provided in previous iteration. This section is complete and consistent with the requirements.)**
## C. Feature Implementation
**(This section refers to the detailed breakdown of User Stories into Tasks, as demonstrated with the example in previous iterations. This is a process that would be repeated for each User Story.)**

**AI Instruction:**  For *each* User Story defined in the Project Specification Document (`ProjectSpecificationDocument.md`), break it down into a set of smaller, manageable tasks. Each task should have a clear description, acceptance criteria, implementation steps, testing guidelines, and a list of dependencies. Follow the example provided in previous iterations for the "Submit Code and Receive Feedback" user story.

**Multi-Agent Workflow Integration (Feature Implementation):**

*   **Task Breakdown (Cursor/Claude):** Use Cursor or Claude to assist in breaking down complex user stories into smaller, well-defined tasks.
*   **Code Generation (Cursor/Claude):** Use Cursor or Claude to generate the initial code for each task, based on the task description and implementation steps.
*   **Code Review (Cursor/Claude):** Use Cursor or Claude to review the generated code, identify potential issues, and suggest improvements.
*   **Testing (Cursor/Claude/v0):** Use Cursor or Claude to generate unit tests and integration tests for each task. Use v0 to generate the front-end.
*   **Refactoring (Cursor/Claude):** Use Cursor or Claude to refactor the code for better readability, maintainability, and performance.
* **UI Component Development (v0):**
    * **Prompt:** "Generate a Next.js 14 component using shadcn/ui and Tailwind CSS for [specific component, e.g., a card to display challenge details]. The component should accept [specific props, e.g., challenge title, description, difficulty, category] and render them appropriately.  The component should be fully responsive and accessible (WCAG 2.1 AA compliant)."
    * **Iteration:** Use v0 to generate the initial UI component. Refine the prompt based on the output, providing specific feedback (e.g., "Make the button larger," "Use a different color for the difficulty label," "Add a loading state").
    * **Integration:** Integrate the generated component into the application, ensuring it works correctly with the backend API and other components. Use Cursor to assist with this integration.
* **Backend Logic Implementation (Claude):**
    * **Prompt:** "Implement the `[specific function, e.g., submitCode]` function in the `[specific service, e.g., SubmissionService]` class. This function should [detailed description of the function's purpose and logic].  It should handle the following error conditions: [list of error conditions].  It should use the following dependencies: [list of dependencies].  It should adhere to the following coding standards: [link to coding standards document].  Return a [specific data type] object. Use efficient database queries and ensure data consistency. Use the following data models [Data models]."
    * **Iteration:** Provide the initial prompt to Claude. Review the generated code. Provide feedback and iterate on the prompt to refine the code.  Ask Claude to generate unit tests for the function.
    * **Integration:** Use Cursor to integrate the generated function into the existing codebase, ensuring proper error handling and dependency injection.
* **Documentation (Cursor/Claude):** Use Cursor or Claude to generate documentation, and complete it, if there is any missing part.

**AI Instruction:** Follow this multi-agent workflow for implementing each feature. Use v0 for frontend component generation, Claude for backend logic implementation, and Cursor for code refinement, integration, debugging, testing, and documentation.

## D. Deployment and Maintenance

### D.1 Deployment Process

**(Already provided in previous iterations. This section is complete and consistent with the requirements.)**

### D.2 Monitoring and Logging
**(Already provided in previous iterations. This section is complete and consistent with the requirements.)**

### D.3 Maintenance and Updates

*   **Regular Dependency Updates:**  Use `npm outdated` to identify outdated dependencies and update them regularly.  Prioritize security updates.
*   **Security Patches:**  Apply security patches for dependencies and the operating system as soon as they are available.  Monitor security advisories for all used technologies.
*   **Bug Fixes:**  Address bug reports promptly and deploy fixes as needed.  Use a bug tracking system (e.g., Jira, GitHub Issues) to manage bug reports.
*   **Feature Releases:**  Plan and release new features on a regular schedule (e.g., bi-weekly or monthly).  Use feature flags to control the rollout of new features.
*   **Database Maintenance:**  Perform regular database backups, optimize queries, and monitor database performance.  Use database monitoring tools (e.g., pgAdmin, Datadog).
* **Monitor System Performance:** Regularly monitor system, API, and user performance.
* **Refactoring:** Do refactoring based on the reports, and feedback.

**AI Instruction:**  Implement a robust maintenance and update process.  Regularly update dependencies, apply security patches, and address bug reports.

## E. Coding Standards and Best Practices
**(Already provided in previous iterations. This section is complete and consistent with the requirements.)**
### E.1 Coding Style Guide
*   **JavaScript/TypeScript:**
    *   Use `const` and `let` instead of `var`.
    *   Prefer arrow functions (`=>`) over traditional function declarations.
    *   Use template literals for string interpolation.
    *   Use object destructuring and the spread operator.
    *   Use asynchronous operations with `async/await`.
    *   Avoid complex nested logic; use guard clauses and early returns.
    *  Use `===`, and `!==` instead of `==` and `!=`

*   **React:**
    *   Use functional components with hooks.
    *   Use descriptive component names (PascalCase).
    *   Keep components small and focused.
    *   Use props for passing data to components.
    *   Use state for managing component-specific data.
    *   Use context for sharing data between components (sparingly).
    *   Use controlled components for form inputs.
    *   Use keys when rendering lists.
    *   Follow React best practices for performance optimization (e.g., memoization, useMemo, useCallback).

*   **CSS:**
    *   Use Tailwind CSS utility classes.
    *   Use the BEM methodology for custom CSS class names.
    *   Avoid inline styles.
    *   Use CSS variables for consistent theming.

*   **General:**
    *   Use meaningful variable and function names.
    *   Write clear and concise comments. Explain *why* the code is written the way it is, not just *what* it does.
    *   Keep functions short and focused (ideally < 20 lines).
    *   Avoid code duplication; create reusable functions and components.
    *   Use consistent indentation (2 spaces).
    *   Use consistent line breaks.
    *   Handle errors gracefully.

### E.2 Error Handling
**(Content already provided in previous sections, consolidated here):**

*   **Centralized Error Handling:** Use a centralized error handling middleware in Express.js (`middleware/error.middleware.ts`) to catch errors and return consistent error responses.
*   **Custom Error Classes:** Create custom error classes (extending the built-in `Error` class) for different types of errors (e.g., `BadRequestError`, `UnauthorizedError`, `NotFoundError`, `ExecutionError`).  These classes are defined in `backend/src/lib/errors.ts`.
*   **Error Codes:** Include specific error codes in error responses (e.g., `INVALID_INPUT`, `USER_NOT_FOUND`, `DATABASE_ERROR`). Maintain a list of error codes in `backend/src/lib/error-codes.ts` (AI Instruction: create this file and populate it with error codes based on the error handling logic in the services).
*   **Error Logging:** Log all errors with sufficient context (user ID, request ID, timestamp, stack trace) using the `pino` logger (`backend/src/lib/logger.ts`).
*   **User-Friendly Messages:** Return user-friendly error messages to the client, but do *not* expose sensitive information.  Only expose detailed error information in the development environment.
* **Input Validation:** Use Zod for validating inputs.

### E.3 Code Review Process

1.  **Create Pull Request:**  Create a pull request on GitHub when a feature or bug fix is ready for review.
2.  **Automated Checks:**  The CI/CD pipeline should automatically run linters, tests, and security scans.  The PR should not be mergeable until all checks pass.
3.  **Peer Review:**  At least one other developer (or a designated AI reviewer) must review the code.
4.  **Review Guidelines:**
    *   Check for code correctness, readability, and maintainability.
    *   Ensure adherence to coding standards and best practices.
    *   Verify that tests are comprehensive and cover all relevant scenarios.
    *   Consider performance, scalability, and security implications.
    *   Provide constructive feedback and suggestions.  Be specific and actionable.
    *   Use a consistent format for feedback (e.g., line comments, overall summary).
5.  **Address Feedback:**  The author of the pull request must address all feedback and make necessary changes. This may involve multiple rounds of review and revision.
6.  **Approval:**  Once the reviewer(s) are satisfied, they approve the pull request.
7.  **Merge:**  Once approved, the PR can be merged into the target branch.  Use the "Squash and Merge" option on GitHub to create a clean commit history.

### E.4 Testing Strategy

*   **Unit Tests:** Test individual functions and components in isolation. Use `vitest`.
*   **Integration Tests:** Test the interaction between different components and services.  Use `vitest` and `supertest` (for backend API testing).
*   **End-to-End Tests:** Test the entire application flow from the user's perspective, simulating real user interactions. Use Playwright.
*   **Performance Tests:** Measure the performance of critical API endpoints and user flows. Use tools like `k6` or `Artillery`.
*   **Security Tests:**  Perform security scans and penetration testing to identify vulnerabilities. (Tools and process described in Section 10.4).
*   **Test Coverage:**  Aim for at least 80% code coverage (lines, functions, branches, statements). Use Vitest's built-in coverage reporting (`--coverage`).
*   **Test-Driven Development (TDD):**  Write tests *before* writing the code (where appropriate).
* **Test file naming:** Test files should have `.test.ts` or `.spec.ts` extension.

**AI Instruction:** Adhere to the testing strategy outlined above. Write comprehensive tests for all code.  Enforce test coverage targets in the CI/CD pipeline.

## F. Error Handling and Exception Management

**(This section consolidates error handling information from previous sections and provides additional details.)**

### F.1 Error Classification

Categorize errors to handle them consistently:

*   **Validation Errors:** Errors caused by invalid user input (e.g., incorrect email format, missing required field).
*   **Authentication Errors:** Errors related to user authentication (e.g., invalid credentials, missing token).
*   **Authorization Errors:** Errors related to user permissions (e.g., accessing a resource without the required role).
*   **Database Errors:** Errors related to database operations (e.g., connection errors, query errors).
*   **Network Errors:** Errors related to network communication (e.g., API request timeouts, connection refused).
*   **Code Execution Errors:** Errors that occur during code execution in the sandbox (e.g., runtime exceptions, test failures).
*   **AI Provider Errors:** Errors returned by the AI provider API (e.g., rate limits, service unavailability).
*   **System Errors:** Unexpected errors that are not covered by the above categories (e.g., internal server errors).

### F.2 Error Codes

Define a system of error codes and messages for different error types.  Maintain a central list of error codes in `backend/src/lib/error-codes.ts`.

**Example `error-codes.ts`:**

```typescript
// backend/src/lib/error-codes.ts
export const ErrorCodes = {
  // General Errors
  INTERNAL_SERVER_ERROR: 'INTERNAL_SERVER_ERROR',
  BAD_REQUEST: 'BAD_REQUEST',
  UNAUTHORIZED: 'UNAUTHORIZED',
  FORBIDDEN: 'FORBIDDEN',
  NOT_FOUND: 'NOT_FOUND',
  CONFLICT: 'CONFLICT',
  TOO_MANY_REQUESTS: 'TOO_MANY_REQUESTS',

  // Validation Errors
  VALIDATION_ERROR: 'VALIDATION_ERROR',
  INVALID_INPUT: 'INVALID_INPUT',

  // Authentication Errors
  INVALID_CREDENTIALS: 'INVALID_CREDENTIALS',
  TOKEN_EXPIRED: 'TOKEN_EXPIRED',
  TOKEN_INVALID: 'TOKEN_INVALID',
  TOKEN_REVOKED: 'TOKEN_REVOKED',
  MISSING_TOKEN: 'MISSING_TOKEN',

  // Database Errors
  DATABASE_ERROR: 'DATABASE_ERROR',
  UNIQUE_CONSTRAINT: 'UNIQUE_CONSTRAINT',
  RECORD_NOT_FOUND: 'RECORD_NOT_FOUND',

  // Code Execution Errors
  EXECUTION_ERROR: 'EXECUTION_ERROR',
  EXECUTION_TIMEOUT: 'EXECUTION_TIMEOUT',
  EXECUTION_FAILED: 'EXECUTION_FAILED',

  // AI Provider Errors
  AI_PROVIDER_ERROR: 'AI_PROVIDER_ERROR',
  AI_REQUEST_TIMEOUT: 'AI_REQUEST_TIMEOUT',

  // ... other specific error codes ...
} as const;

// Type for error codes
export type ErrorCode = typeof ErrorCodes[keyof typeof ErrorCodes];

```

**AI Instruction:**  Use these error codes consistently throughout the application.  When throwing an error, use the appropriate `AppError` subclass and provide a corresponding error code.

### F.3 Exception Handling

*   Use `try...catch` blocks to handle exceptions in JavaScript/TypeScript.
*   Throw custom error objects (derived from the `AppError` class) to provide more context.
*   Use the centralized error handling middleware in Express.js (`middleware/error.middleware.ts`) to catch unhandled exceptions and return consistent error responses.
*  Use Zod for request validation, to prevent unexpected input.

### F.4 Logging

**(Already fully detailed in previous iterations and in Section 11.3.  Reproduced here for context.)**

*   Use the `pino` logger (`backend/src/lib/logger.ts`).
*   Log all errors and exceptions with sufficient context:
    *   `requestId`: A unique ID for each request.
    *   `userId`: The ID of the authenticated user (if available).
    *   `method`: The HTTP method (GET, POST, etc.).
    *   `path`: The request path.
    *   `query`: The query parameters.
    *   `body`: The request body (limit the size to avoid logging sensitive data).
    *   `error`: The error object (including stack trace).
    *   `statusCode`: The HTTP status code.
    *   `code`: The error code.
    *   `message`: A human-readable error message.
    *   `details`: Any additional details (e.g., validation errors).
*   Use different log levels (DEBUG, INFO, WARN, ERROR, FATAL) to categorize log messages.
*   Log important events (e.g., user registration, login, code submission, feedback generation).

### F.5 Recovery

*   **Code Execution:** If code execution fails due to a system error (e.g., Docker container crash), retry the execution a limited number of times (defined in `code-executor.service.ts`). If it still fails, return an error to the user and log the error.
*   **AI Feedback:** If AI feedback generation fails, fall back to a simpler feedback mechanism (e.g., rule-based feedback) or return a generic message to the user.
*   **Database:** Use database transactions to ensure data consistency. Implement automatic retries for transient database errors.
*   **External Services:** Implement retry mechanisms with exponential backoff for calls to external services (e.g., AI provider, GitHub API). Use the Circuit Breaker pattern to prevent cascading failures.
* **Queue:** Implement queue system to handle asynchronous tasks.

## G. Contingency Planning

### G.1 Rollback Procedures

**Deployment Rollbacks:**

1.  **Automated Rollbacks:** Configure the DigitalOcean App Platform (and later Kubernetes) to automatically roll back to the previous deployment if the new deployment fails health checks.
2.  **Manual Rollbacks:** Provide a script or command-line tool to manually trigger a rollback to a specific previous version.  This script should use the `doctl apps update` command with the appropriate image tag.  Example:

    ```bash
    # Rollback to a specific SHA
    doctl apps update <app-id> --image registry.digitalocean.com/kodelab/backend:<previous-sha>

    # Rollback to a specific branch (not recommended for production)
    # doctl apps update <app-id> --spec ./deploy/production.yaml
    ```

3.  **Database Migrations:** Use a database migration tool (Prisma Migrate) that supports both up and down migrations. Ensure that all migrations are reversible.  *Always* test rollbacks in a staging environment before deploying to production.

4.  **Feature Flags:** Use feature flags to enable/disable new features without requiring a deployment. This allows for quick rollback of problematic features.

**AI Instruction:** Create scripts for manual rollback procedures for both the frontend and backend services. Document the steps clearly in the `docs/` directory. Include instructions for rolling back database migrations.

### G.2 Data Backup and Restore

**Backup Strategy:**

*   **Automated Daily Backups:** Configure automated daily backups of the PostgreSQL database. Use DigitalOcean's managed database backup feature (or a similar feature on other cloud providers).
*   **Offsite Storage:** Store backups in a geographically separate location (e.g., AWS S3 with cross-region replication, or DigitalOcean Spaces in a different region).
*   **Retention Policy:** Retain backups for at least 30 days.  Consider longer retention periods for compliance or disaster recovery purposes.
*   **Encryption:** Encrypt backups at rest and in transit.
*   **Regular Testing:** Regularly test the backup and restore process to ensure its reliability.
* **Point-in-Time Recovery:** Enable point-in-time recovery for database.

**Restore Procedures:**

1.  **Stop Application Services:** Stop all application services that access the database.
2.  **Restore Database Backup:** Restore the database from the most recent backup using the appropriate tools (e.g., `pg_restore` for PostgreSQL, DigitalOcean's managed database restore functionality).
3.  **Verify Data Integrity:** Verify that the restored data is consistent and complete.  Run data validation checks.
4.  **Restart Application Services:** Restart the application services.
5.  **Test Application Functionality:** Thoroughly test the application to ensure it is working correctly.

**AI Instruction:** Create scripts to automate the database backup process. Document the manual steps for restoring from a backup.  Include instructions for verifying data integrity after a restore.

### G.3 Disaster Recovery

**Disaster Recovery Plan:**

1.  **Multi-Region Deployment:** Deploy the application to multiple geographic regions (e.g., DigitalOcean NYC1 and SFO3). This provides redundancy in case of a regional outage.
2.  **Load Balancing:** Use a global load balancer (e.g., Cloudflare, DigitalOcean Load Balancer) to distribute traffic across regions.
3.  **Failover Mechanism:** Configure automatic failover to the secondary region if the primary region becomes unavailable. This can be achieved using DNS failover (e.g., with Cloudflare) or by monitoring the health of the application instances and updating load balancer configurations.
4.  **Data Replication:** Use database replication (e.g., PostgreSQL streaming replication) to ensure data consistency across regions. Configure asynchronous replication for minimal performance impact.
5.  **Regular Drills:** Conduct regular disaster recovery drills to test the plan and identify any weaknesses.  These drills should simulate a complete outage of the primary region.

**Recovery Time Objective (RTO):** 1 hour (The maximum acceptable downtime)
**Recovery Point Objective (RPO):** 15 minutes (The maximum acceptable data loss)

**AI Instruction:** Develop a detailed disaster recovery plan, including specific steps for failover and recovery. Include diagrams illustrating the multi-region architecture.  Document the RTO and RPO targets.  Outline the procedures for regular disaster recovery drills.

This now concludes the *complete* Master Project Blueprint, Version 3.0. All sections from the original prompt, all iterative improvements, and all requested details have been included. This document is now ready for use by AI coding agents.
