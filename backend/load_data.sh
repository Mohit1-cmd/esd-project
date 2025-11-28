#!/bin/bash

# Manual Database Population Script
# Use this if automatic data loading doesn't work

echo "Connecting to MySQL and running data.sql..."

# Load environment variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Get MySQL credentials from environment or use defaults
MYSQL_USER=${MYSQL_USERNAME:-root}
MYSQL_PASS=${MYSQL_PASSWORD:-password}
MYSQL_DB="esd_db"

echo "Database: $MYSQL_DB"
echo "User: $MYSQL_USER"

# Run the SQL script
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" < src/main/resources/data.sql

if [ $? -eq 0 ]; then
    echo "✅ Data loaded successfully!"
    echo "Checking record counts..."
    mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" -e "
        SELECT 'Domains:' as TableName, COUNT(*) as Count FROM domain
        UNION ALL SELECT 'Specializations:', COUNT(*) FROM specialization
        UNION ALL SELECT 'Courses:', COUNT(*) FROM course
        UNION ALL SELECT 'Students:', COUNT(*) FROM student
        UNION ALL SELECT 'Enrollments:', COUNT(*) FROM student_course
        UNION ALL SELECT 'Course-Spec Mappings:', COUNT(*) FROM course_specialization;
    "
else
    echo "❌ Error loading data!"
    exit 1
fi
