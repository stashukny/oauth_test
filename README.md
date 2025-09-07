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

### Quick Deploy with Script

Use the automated deployment script:

```bash
./heroku-deploy.sh
```

This script will:
1. Deploy backend to Heroku
2. Set up environment variables
3. Provide instructions for frontend deployment
4. Guide you through Google OAuth configuration

### Manual Deployment

#### Backend to Heroku

1. **Create Heroku app:**
   ```bash
   cd backend
   heroku create your-backend-app-name
   ```

2. **Set environment variables:**
   ```bash
   heroku config:set GOOGLE_CLIENT_ID="your_google_client_id" --app your-backend-app-name
   heroku config:set ALLOWED_ORIGINS="http://localhost:3000,https://your-frontend.vercel.app" --app your-backend-app-name
   ```

3. **Deploy:**
   ```bash
   git init
   git add .
   git commit -m "Initial deployment"
   heroku git:remote -a your-backend-app-name
   git push heroku main
   ```

#### Frontend to Vercel

1. **Install Vercel CLI:**
   ```bash
   npm i -g vercel
   ```

2. **Deploy:**
   ```bash
   cd frontend
   vercel
   ```

3. **Set environment variables in Vercel dashboard:**
   - `NEXT_PUBLIC_GOOGLE_CLIENT_ID=your_google_client_id`
   - `NEXT_PUBLIC_BACKEND_URL=https://your-backend-app.herokuapp.com`

#### Google OAuth Configuration for Production

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Navigate to "Credentials" 
3. Edit your OAuth 2.0 client
4. Add to **Authorized JavaScript origins:**
   - `https://your-frontend.vercel.app`
5. Add to **Authorized redirect URIs:**
   - `https://your-frontend.vercel.app`

#### Update Backend CORS

After deploying frontend, update your backend's allowed origins:

```bash
heroku config:set ALLOWED_ORIGINS="http://localhost:3000,https://your-frontend.vercel.app" --app your-backend-app-name
```

### Environment Variables Summary

**Backend (.env):**
```
GOOGLE_CLIENT_ID=your_google_client_id
ALLOWED_ORIGINS=http://localhost:3000,https://your-frontend.vercel.app
```

**Frontend (.env.local):**
```
NEXT_PUBLIC_GOOGLE_CLIENT_ID=your_google_client_id
NEXT_PUBLIC_BACKEND_URL=https://your-backend-app.herokuapp.com
```

### Deployment Files

- `backend/Procfile` - Heroku process configuration
- `backend/runtime.txt` - Python version specification
- `heroku-deploy.sh` - Automated deployment script