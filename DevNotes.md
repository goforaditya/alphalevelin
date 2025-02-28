# AlphaLevelin Development Notes

## OAuth Configuration

The application supports login via GitHub and Google. To configure:

### GitHub OAuth

1. Go to [GitHub Developer Settings](https://github.com/settings/developers)
2. Click "New OAuth App"
3. Fill in the details:
   - Application name: AlphaLevelin (or your preferred name)
   - Homepage URL: http://localhost:3000 (for development)
   - Authorization callback URL: http://localhost:3000/auth/github/callback
4. After registration, you'll receive a Client ID and Secret
5. Set these as environment variables:
   ```
   export GITHUB_KEY=your_client_id
   export GITHUB_SECRET=your_client_secret
   ```

### Google OAuth

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project
3. Go to APIs & Services > OAuth Consent Screen and configure it
4. Go to APIs & Services > Credentials
5. Create OAuth client ID credentials (Web Application)
6. Add authorized redirect URI: http://localhost:3000/auth/google_oauth2/callback
7. Set the credentials as environment variables:
   ```
   export GOOGLE_CLIENT_ID=your_client_id
   export GOOGLE_CLIENT_SECRET=your_client_secret
   ```

For development, placeholder values are provided in the initializer, but they won't allow actual authentication.

## Markdown Features

When creating posts, you can either:
1. Write markdown directly in the visual editor (SimpleMDE)
2. Provide a GitHub URL to a markdown file (which will be fetched and rendered)

The application will automatically render markdown content with proper styling.