#!/bin/bash

# GitHub Upload Script for Amazon Q Repository
# Run this script from your local amazon-q repository directory

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🚀 Amazon Q Repository Upload Script${NC}"
echo "================================================"

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  Not in a git repository. Please run this from your amazon-q repository directory.${NC}"
    exit 1
fi

# Create directory structure
echo -e "${BLUE}📁 Creating directory structure...${NC}"
mkdir -p scripts docs examples .github/ISSUE_TEMPLATE

# Copy main files
echo -e "${BLUE}📄 Copying repository files...${NC}"
cp /home/k8s/projects/aws-community/q/blog/README.md .
cp /home/k8s/projects/aws-community/q/blog/CONTRIBUTING.md .
cp /home/k8s/projects/aws-community/q/blog/LICENSE .

# Copy and make setup script executable
cp /home/k8s/projects/aws-community/q/blog/setup-amazon-q.sh scripts/
chmod +x scripts/setup-amazon-q.sh

echo -e "${GREEN}✅ Files copied successfully!${NC}"

# Show git status
echo -e "${BLUE}📊 Git Status:${NC}"
git status

# Add files to git
echo -e "${BLUE}➕ Adding files to git...${NC}"
git add .

# Commit with detailed message
echo -e "${BLUE}💾 Committing changes...${NC}"
git commit -m "feat: add comprehensive Amazon Q Developer Pro setup guide

🎯 Features Added:
- Complete step-by-step setup documentation
- Automated setup script with error handling
- Real-world implementation examples
- Comprehensive troubleshooting guide
- Professional GitHub repository structure

📚 Documentation:
- README.md with detailed instructions
- CONTRIBUTING.md for community collaboration
- LICENSE (MIT) for open source usage

🔧 Automation:
- Interactive setup script (scripts/setup-amazon-q.sh)
- Input validation and error handling
- Configuration file generation

🐛 Troubleshooting:
- Common issues and solutions
- Debug commands and verification steps
- Regional availability considerations

Based on real production implementation and testing."

echo -e "${GREEN}✅ Files committed successfully!${NC}"

# Push to GitHub
echo -e "${BLUE}🚀 Pushing to GitHub...${NC}"
git push origin main

echo -e "${GREEN}🎉 Repository updated successfully!${NC}"
echo -e "${BLUE}🔗 View your repository at: https://github.com/manikcloud/amazon-q${NC}"

echo -e "\n${YELLOW}📋 Next Steps:${NC}"
echo "1. Visit your GitHub repository"
echo "2. Check that all files are uploaded correctly"
echo "3. Update repository description and topics"
echo "4. Consider adding GitHub Actions for automation"
echo "5. Share with the community!"
