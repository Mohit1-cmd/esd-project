package com.mohit.end_project.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

    @GetMapping("/")
    @ResponseBody
    public String home() {
        return """
                <html>
                <head>
                    <title>Spring Boot OAuth Demo</title>
                    <style>
                        body {
                            font-family: Arial, sans-serif;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            height: 100vh;
                            margin: 0;
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        }
                        .container {
                            text-align: center;
                            background: white;
                            padding: 3rem;
                            border-radius: 10px;
                            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
                        }
                        h1 { color: #333; margin-bottom: 1rem; }
                        p { color: #666; margin-bottom: 2rem; }
                        a {
                            display: inline-block;
                            background: #4285f4;
                            color: white;
                            padding: 12px 30px;
                            text-decoration: none;
                            border-radius: 5px;
                            font-weight: bold;
                            transition: background 0.3s;
                        }
                        a:hover { background: #357ae8; }
                    </style>
                </head>
                <body>
                    <div class="container">
                        <h1>Welcome to Spring Boot OAuth Demo</h1>
                        <p>This application demonstrates Google OAuth 2.0 integration</p>
                        <a href="/oauth2/authorization/google">Login with Google</a>
                    </div>
                </body>
                </html>
                """;
    }

    @GetMapping("/dashboard")
    @ResponseBody
    public String dashboard(@AuthenticationPrincipal OAuth2User principal) {
        String name = principal.getAttribute("name");
        String email = principal.getAttribute("email");
        String picture = principal.getAttribute("picture");

        return String.format("""
                <html>
                <head>
                    <title>Dashboard</title>
                    <style>
                        body {
                            font-family: Arial, sans-serif;
                            background: #f5f5f5;
                            padding: 2rem;
                        }
                        .dashboard {
                            max-width: 800px;
                            margin: 0 auto;
                            background: white;
                            padding: 2rem;
                            border-radius: 10px;
                            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                        }
                        .profile {
                            display: flex;
                            align-items: center;
                            margin-bottom: 2rem;
                        }
                        .profile img {
                            width: 80px;
                            height: 80px;
                            border-radius: 50%%;
                            margin-right: 1.5rem;
                        }
                        .profile-info h2 { margin: 0; color: #333; }
                        .profile-info p { margin: 0.5rem 0 0 0; color: #666; }
                        .links a {
                            display: inline-block;
                            margin-right: 1rem;
                            color: #4285f4;
                            text-decoration: none;
                        }
                        .links a:hover { text-decoration: underline; }
                        .success {
                            background: #d4edda;
                            color: #155724;
                            padding: 1rem;
                            border-radius: 5px;
                            margin-bottom: 1rem;
                        }
                    </style>
                </head>
                <body>
                    <div class="dashboard">
                        <div class="success">✓ Successfully authenticated with Google OAuth 2.0</div>
                        <div class="profile">
                            <img src="%s" alt="Profile Picture">
                            <div class="profile-info">
                                <h2>%s</h2>
                                <p>%s</p>
                            </div>
                        </div>
                        <div class="links">
                            <a href="/api/user/me">View User Profile (JSON)</a>
                            <a href="/api/users">View All Users (JSON)</a>
                            <a href="/logout">Logout</a>
                        </div>
                    </div>
                </body>
                </html>
                """, picture, name, email);
    }
}
