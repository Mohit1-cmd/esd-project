#!/bin/bash

# Test API endpoints with authentication
# This helps us understand what the frontend is experiencing

echo "=== Testing Backend API Endpoints ==="
echo ""

echo "1. Testing /api/students endpoint:"
curl -s -w "\nStatus: %{http_code}\n" http://localhost:8080/api/students | head -5
echo ""

echo "2. Testing /api/courses endpoint:"
curl -s -w "\nStatus: %{http_code}\n" http://localhost:8080/api/courses | head -5
echo ""

echo "3. Testing /api/domains endpoint:"
curl -s -w "\nStatus: %{http_code}\n" http://localhost:8080/api/domains | head -5
echo ""

echo "4. Testing with Chrome user agent (simulating browser):"
curl -s -H "User-Agent: Mozilla/5.0" -w "\nStatus: %{http_code}\n" http://localhost:8080/api/students | head -5
echo ""

echo "=== Check browser console for actual errors ==="
