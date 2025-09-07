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

# Set buildpack for Python
echo "Setting Python buildpack..."
heroku buildpacks:set heroku/python --app $BACKEND_APP

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

cd ..

echo ""
echo "🌐 Backend deployed to: https://$BACKEND_APP.herokuapp.com"
echo ""

# Ask if user wants to deploy frontend to Heroku too
echo "🤔 Frontend Deployment Options:"
echo "================================"
echo "1. Deploy to Heroku (Node.js app)"
echo "2. Deploy to Vercel (recommended for Next.js)"
echo ""
read -p "Choose option (1 or 2): " DEPLOY_CHOICE

if [[ "$DEPLOY_CHOICE" == "1" ]]; then
    echo ""
    echo "🔧 Deploying Frontend to Heroku..."
    echo "=================================="
    
    cd frontend
    
    # Create Heroku app for frontend
    echo "Creating Heroku app: $FRONTEND_APP"
    heroku create $FRONTEND_APP
    
    # Set buildpack for Node.js
    echo "Setting Node.js buildpack..."
    heroku buildpacks:set heroku/nodejs --app $FRONTEND_APP
    
    # Set environment variables
    heroku config:set NEXT_PUBLIC_GOOGLE_CLIENT_ID="$GOOGLE_CLIENT_ID" --app $FRONTEND_APP
    heroku config:set NEXT_PUBLIC_BACKEND_URL="https://$BACKEND_APP.herokuapp.com" --app $FRONTEND_APP
    
    # Deploy frontend
    echo "🚀 Deploying frontend..."
    git init
    git add .
    git commit -m "Initial frontend deployment"
    heroku git:remote -a $FRONTEND_APP
    git push heroku main
    
    cd ..
    
    FRONTEND_URL="https://$FRONTEND_APP.herokuapp.com"
else
    FRONTEND_URL="https://$FRONTEND_APP.vercel.app"
    echo ""
    echo "📋 Manual Vercel Deployment Steps:"
    echo "================================="
    echo "1. Install Vercel CLI: npm i -g vercel"
    echo "2. cd frontend"
    echo "3. vercel"
    echo "4. Set environment variables in Vercel dashboard:"
    echo "   NEXT_PUBLIC_GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID"
    echo "   NEXT_PUBLIC_BACKEND_URL=https://$BACKEND_APP.herokuapp.com"
fi

echo ""
echo "📋 Final Steps:"
echo "==============="
echo "1. Update your Google OAuth settings:"
echo "   - Go to Google Cloud Console"
echo "   - Add $FRONTEND_URL to authorized origins"
echo ""
echo "2. Update backend CORS settings:"
echo "   heroku config:set ALLOWED_ORIGINS=\"http://localhost:3000,$FRONTEND_URL\" --app $BACKEND_APP"
echo ""
echo "🌐 URLs:"
echo "  Backend:  https://$BACKEND_APP.herokuapp.com"
echo "  Frontend: $FRONTEND_URL"
echo ""
echo "✅ Deployment complete!"