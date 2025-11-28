#!/bin/bash

# Export environment variables from .env file
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
    echo "✓ Environment variables loaded from .env"
else
    echo "⚠️  Warning: .env file not found. Using default values."
fi

# Run Maven with toolchains to use Java 17
exec ./mvnw spring-boot:run -t .mvn/toolchains.xml "$@"
