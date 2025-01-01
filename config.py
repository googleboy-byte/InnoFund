from dotenv import load_dotenv
import os
from datetime import timedelta

load_dotenv()  # Load environment variables from .env file

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'your-secret-key-here'
    SESSION_TYPE = 'filesystem'
    PERMANENT_SESSION_LIFETIME = timedelta(days=7)
    SESSION_COOKIE_SECURE = False  # Set to True in production with HTTPS
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'
    REMEMBER_COOKIE_DURATION = timedelta(days=7)
    FIREBASE_CREDENTIALS = os.environ.get('FIREBASE_CREDENTIALS')
    PROJECTS_FIREBASE_CREDENTIALS = os.environ.get('PROJECTS_FIREBASE_CREDENTIALS')
    FIREBASE_DATABASE_URL = os.environ.get('FIREBASE_DATABASE_URL')
    PROJECTS_DATABASE_URL = os.environ.get('PROJECTS_DATABASE_URL')
    PROJECTS_STORAGE_BUCKET = os.environ.get('PROJECTS_STORAGE_BUCKET')
    
    # OAuth Credentials
    GOOGLE_CLIENT_ID = os.environ.get('GOOGLE_CLIENT_ID')
    GOOGLE_CLIENT_SECRET = os.environ.get('GOOGLE_CLIENT_SECRET')
    GITHUB_CLIENT_ID = os.environ.get('GITHUB_CLIENT_ID')
    GITHUB_CLIENT_SECRET = os.environ.get('GITHUB_CLIENT_SECRET') 
    
    # Storage Firebase
    STORAGE_FIREBASE_CREDENTIALS = os.environ.get('STORAGE_FIREBASE_CREDENTIALS')
    STORAGE_BUCKET = os.environ.get('STORAGE_BUCKET')
    
    # RTDB Firebase
    RTDB_FIREBASE_CREDENTIALS = os.environ.get('RTDB_FIREBASE_CREDENTIALS')
    RTDB_DATABASE_URL = os.environ.get('RTDB_DATABASE_URL') 