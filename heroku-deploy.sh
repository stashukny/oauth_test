#!/bin/bash

echo "🚀 Heroku Deployment Script for OAuth POC App"
echo "=============================================="

# Check if Heroku CLI is installed
if ! command -v heroku &> /dev/null; then
    echo "❌ Heroku CLI is not installed. Please install it first:"
    echo "   https://devcenter.heroku.com/articles/heroku-cli"
    exit 1
fi

# Check if user is logged in to Heroku
if ! heroku whoami &> /dev/null; then
    echo "❌ Please log in to Heroku first:"
    echo "   heroku login"
    exit 1
fi

echo "📝 Please provide the following information:"

# Get app names from user
read -p "Enter your backend app name (e.g., my-oauth-backend): " BACKEND_APP
read -p "Enter your frontend app name (e.g., my-oauth-frontend): " FRONTEND_APP

# Validate app names
if [[ -z "$BACKEND_APP" || -z "$FRONTEND_APP" ]]; then
    echo "❌ Both app names are required!"
    exit 1
fi

echo ""
echo "🔧 Deploying Backend to Heroku..."
echo "================================="

# Deploy backend
cd backend

# Create Heroku app for backend
echo "Creating Heroku app: $BACKEND_APP"
heroku create $BACKEND_APP

# Set environment variables
echo "⚙️  Please set your Google Client ID:"
read -p "Enter your GOOGLE_CLIENT_ID: " GOOGLE_CLIENT_ID

if [[ -n "$GOOGLE_CLIENT_ID" ]]; then
    heroku config:set GOOGLE_CLIENT_ID="$GOOGLE_CLIENT_ID" --app $BACKEND_APP
fi

# Deploy backend
echo "🚀 Deploying backend..."
git init
git add .
git commit -m "Initial backend deployment"
heroku git:remote -a $BACKEND_APP
git push heroku main

cd ..

echo ""
echo "🌐 Backend deployed to: https://$BACKEND_APP.herokuapp.com"
echo ""
echo "📋 Next Steps:"
echo "=============="
echo "1. Update your Google OAuth settings:"
echo "   - Go to Google Cloud Console"
echo "   - Add https://$FRONTEND_APP.vercel.app to authorized origins"
echo ""
echo "2. Deploy your frontend to Vercel:"
echo "   - Install Vercel CLI: npm i -g vercel"
echo "   - cd frontend"
echo "   - vercel"
echo "   - Set environment variables in Vercel dashboard:"
echo "     NEXT_PUBLIC_GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID"
echo "     NEXT_PUBLIC_BACKEND_URL=https://$BACKEND_APP.herokuapp.com"
echo ""
echo "3. Update backend CORS settings:"
echo "   heroku config:set ALLOWED_ORIGINS=\"http://localhost:3000,https://localhost:3000,https://$FRONTEND_APP.vercel.app\" --app $BACKEND_APP"
echo ""
echo "✅ Deployment complete!"