# GitHub Repository Read Access script

## Overview
The **GitHub Repository Read Access scriptr** is a Bash-based automation script
that interacts with the **GitHub REST API** to identify users who have **read (pull) access** to a specific GitHub repository.


---

## Prerequisites
Before running this script, ensure the following tools and configurations are in place:

- **Bash shell**
- **curl** (for API requests)
- **jq** (for JSON parsing)
- **GitHub Personal Access Token (PAT)**

### GitHub Credentials
Sensitive authentication details must not be hardcoded.

Use placeholders for:
- `[GITHUB_USERNAME]`
- `[GITHUB_TOKEN]`

Example (recommended approach):
```bash
export username="YOUR_GITHUB_USERNAME"
export token="YOUR_GITHUB_PERSONAL_ACCESS_TOKEN"

Usage

Run the script by passing the repository owner and repository name as arguments:

./github_read_access_audit.sh <REPO_OWNER> <REPO_NAME>

Example:
./github_read_access_audit.sh octocat hello-world


Project Explanation

1. Argument Validation

The helper() function ensures that exactly two arguments are passed:
    Repository owner
    Repository name
If the argument count is incorrect, the script exits with a clear usage message.

2. GitHub API Configuration

The script uses the base GitHub API endpoint:

https://api.github.com


All requests are made using authenticated API calls to ensure access to private repositories (if permitted).

3. Authentication Handling

Authentication is performed using Basic Auth with:

GitHub username
GitHub personal access token

Sensitive credentials are referenced via placeholders:

[GITHUB_USERNAME]
[GITHUB_TOKEN]

4. GitHub API GET Function

A reusable function sends authenticated GET requests to the GitHub API endpoints using curl.
This keeps the script modular and easy to extend for additional API calls.

5. Listing Users with Read Access

The script queries the following endpoint:
repos/{owner}/{repo}/collaborators
Using jq, it filters users who have:
permissions.pull == true

This ensures only users with read access are listed.

6. Output Handling

If users with read access exist, their GitHub usernames are displayed.
If no such users are found, a clear message is printed.
Output is human-readable and suitable for auditing or reporting purposes.

this script only works if you are:
the repository owner, OR
a collaborator / organization member with sufficient permissions.