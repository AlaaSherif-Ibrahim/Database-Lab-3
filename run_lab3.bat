@echo off
echo ============================================================================
echo Alexandria National University - Introduction to Database Systems (Lab 3)
echo Students: A'laa Sherif Ibrahim (2304249) ^& Mariam Mohamed Ali (2304251)
echo ============================================================================

echo.
echo [1/4] Building and seeding Part I: COMPANY Database...
mysql -u root -pRootAlaaSql2028 < problem1_DDL.sql
if %errorlevel% neq 0 (
    echo [ERROR] Failed to run problem1_DDL.sql. Check if MySQL is running and in PATH.
    pause
    exit /b %errorlevel%
)
mysql -u root -pRootAlaaSql2028 < problem1_DML.sql
echo       -> COMPANY database created and populated successfully!

echo.
echo [2/4] Building and seeding Part II: LIBRARY Database...
mysql -u root -pRootAlaaSql2028 < problem2_DDL.sql
mysql -u root -pRootAlaaSql2028 < problem2_DML.sql
echo       -> LIBRARY database created and seeded with 4 authors and 8 books!

echo.
echo [3/4] Installing Python Flask dependencies...
cd website
pip install -r requirements.txt

echo.
echo [4/4] Starting Flask Web Application on http://127.0.0.1:5000 ...
echo       Press CTRL+C to stop the server.
start http://127.0.0.1:5000
python app.py
pause
