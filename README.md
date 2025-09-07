# OAuth POC App

A proof-of-concept application demonstrating Google OAuth integration with FastAPI backend and Next.js frontend.

## Setup

### Prerequisites
- Python 3.8+
- Node.js 18+
- Google OAuth credentials

### Google OAuth Setup
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable the Google+ API
4. Create OAuth 2.0 credentials
5. Add authorized redirect URIs:
   - `http://localhost:3000` (for local development)
   - Your production domain (for deployment)

### Backend Setup
1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Copy environment file and add your Google Client ID:
   ```bash
   cp .env.example .env
   # Edit .env and add your GOOGLE_CLIENT_ID
   ```

5. Run the backend:
   ```bash
   python main.py
   ```

Backend will be available at `http://localhost:8000`

### Frontend Setup
1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Copy environment file and add your Google Client ID:
   ```bash
   cp .env.local.example .env.local
   # Edit .env.local and add your NEXT_PUBLIC_GOOGLE_CLIENT_ID
   ```

4. Run the frontend:
   ```bash
   npm run dev
   ```

Frontend will be available at `http://localhost:3000`

## Testing OAuth Flow

1. Visit `http://localhost:3000`
2. Click "Sign in with Google"
3. Complete OAuth flow
4. Navigate between Dashboard and Profile pages to test session persistence

## Deployment

### Backend (FastAPI)
- Can be deployed to any cloud provider that supports Python (Heroku, Railway, DigitalOcean, etc.)
- Update environment variables for production
- Ensure CORS settings allow your production domain

### Frontend (Next.js)
- Can be deployed to Vercel, Netlify, or any static hosting
- Update environment variables for production
- Ensure Google OAuth authorized origins include production domain