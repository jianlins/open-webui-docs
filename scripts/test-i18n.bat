@echo off
echo Testing multilingual setup for Open WebUI documentation

echo.
echo Step 1: Installing dependencies (if needed)
npm install

echo.
echo Step 2: Building the documentation with translations
npm run build

echo.
echo Step 3: Starting the development server
echo You can now test the multilingual support by visiting:
echo   - English: http://localhost:3000/
echo   - Simplified Chinese: http://localhost:3000/zh-Hans/
echo.
echo Press Ctrl+C to stop the server when done testing.
npm run start

echo.
echo Testing complete!