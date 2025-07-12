#!/bin/bash

# Amazon Q Developer Pro Setup Script
# Author: Varun Kumar
# Description: Automated setup script for Amazon Q Developer Pro with AWS Identity Center

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Banner
echo -e "${BLUE}"
cat << "EOF"
╔══════════════════════════════════════════════════════════════╗
║                 Amazon Q Developer Pro Setup                 ║
║                    Automated Configuration                   ║
╚══════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Check prerequisites
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check AWS CLI
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI is not installed. Please install it first."
        exit 1
    fi
    
    # Check Q CLI
    if ! command -v q &> /dev/null; then
        log_error "Q CLI is not installed. Please install it first."
        exit 1
    fi
    
    # Check AWS credentials
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "AWS credentials not configured. Run 'aws configure' first."
        exit 1
    fi
    
    log_success "All prerequisites met!"
}

# Get user inputs
get_user_inputs() {
    log_info "Gathering configuration details..."
    
    # Get AWS account info
    ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
    CURRENT_USER=$(aws sts get-caller-identity --query Arn --output text)
    
    echo -e "\n${GREEN}Current AWS Configuration:${NC}"
    echo "Account ID: $ACCOUNT_ID"
    echo "User: $CURRENT_USER"
    
    # Get application name
    read -p "Enter your Q Application display name [default: MyQ-Developer-App]: " APP_NAME
    APP_NAME=${APP_NAME:-MyQ-Developer-App}
    
    # Get Identity Center instance ARN
    echo -e "\n${YELLOW}You need your AWS Identity Center instance ARN.${NC}"
    echo "Find it in: AWS Console > Identity Center > Settings"
    echo "Format: arn:aws:sso:::instance/ssoins-xxxxxxxxxxxxxxxxx"
    read -p "Enter your Identity Center instance ARN: " IDC_ARN
    
    if [[ ! $IDC_ARN =~ ^arn:aws:sso:::instance/ssoins- ]]; then
        log_error "Invalid Identity Center ARN format"
        exit 1
    fi
    
    # Get Builder ID
    echo -e "\n${YELLOW}You need your Builder ID (UUID format).${NC}"
    echo "Find it in: AWS Builder ID profile or Identity Center users"
    read -p "Enter your Builder ID: " BUILDER_ID
    
    if [[ ! $BUILDER_ID =~ ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$ ]]; then
        log_error "Invalid Builder ID format (should be UUID)"
        exit 1
    fi
    
    # Confirm settings
    echo -e "\n${BLUE}Configuration Summary:${NC}"
    echo "Application Name: $APP_NAME"
    echo "Identity Center ARN: $IDC_ARN"
    echo "Builder ID: $BUILDER_ID"
    echo "AWS Account: $ACCOUNT_ID"
    
    read -p "Proceed with this configuration? (y/N): " CONFIRM
    if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
        log_info "Setup cancelled by user"
        exit 0
    fi
}

# Create Q Business Application
create_application() {
    log_info "Creating Amazon Q Business Application..."
    
    APP_RESPONSE=$(aws qbusiness create-application \
        --display-name "$APP_NAME" \
        --description "Amazon Q Application for Developer Pro - Created by setup script" \
        --identity-center-instance-arn "$IDC_ARN" \
        --identity-type "AWS_IAM_IDC" \
        --output json)
    
    if [ $? -eq 0 ]; then
        APPLICATION_ID=$(echo $APP_RESPONSE | jq -r '.applicationId')
        APPLICATION_ARN=$(echo $APP_RESPONSE | jq -r '.applicationArn')
        log_success "Application created successfully!"
        echo "Application ID: $APPLICATION_ID"
        echo "Application ARN: $APPLICATION_ARN"
    else
        log_error "Failed to create application"
        exit 1
    fi
}

# Create user in application
create_user() {
    log_info "Creating user in Q Business Application..."
    
    aws qbusiness create-user \
        --application-id "$APPLICATION_ID" \
        --user-id "$BUILDER_ID" \
        --output json > /dev/null
    
    if [ $? -eq 0 ]; then
        log_success "User created successfully!"
    else
        log_error "Failed to create user"
        exit 1
    fi
}

# Create web experience
create_web_experience() {
    log_info "Creating web experience..."
    
    # Get or create service-linked role
    SERVICE_ROLE_ARN="arn:aws:iam::$ACCOUNT_ID:role/aws-service-role/qbusiness.amazonaws.com/AWSServiceRoleForQBusiness"
    
    WEB_RESPONSE=$(aws qbusiness create-web-experience \
        --application-id "$APPLICATION_ID" \
        --title "$APP_NAME Web Experience" \
        --role-arn "$SERVICE_ROLE_ARN" \
        --output json)
    
    if [ $? -eq 0 ]; then
        WEB_EXPERIENCE_ID=$(echo $WEB_RESPONSE | jq -r '.webExperienceId')
        log_success "Web experience created successfully!"
        echo "Web Experience ID: $WEB_EXPERIENCE_ID"
        
        # Get the web experience details to get the URL
        sleep 5  # Wait for the web experience to be ready
        WEB_DETAILS=$(aws qbusiness get-web-experience \
            --application-id "$APPLICATION_ID" \
            --web-experience-id "$WEB_EXPERIENCE_ID" \
            --output json)
        
        WEB_URL=$(echo $WEB_DETAILS | jq -r '.defaultEndpoint')
        log_success "Web interface URL: $WEB_URL"
    else
        log_error "Failed to create web experience"
        exit 1
    fi
}

# Configure Q CLI
configure_q_cli() {
    log_info "Configuring Q CLI..."
    log_warning "You'll need to complete the device authorization flow manually"
    
    echo -e "\n${YELLOW}Please run the following command and follow the prompts:${NC}"
    echo "q login --license free"
    echo -e "\nThis will open a browser for authentication with your Builder ID."
}

# Generate summary
generate_summary() {
    log_success "Amazon Q Developer Pro setup completed!"
    
    echo -e "\n${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}                        SETUP SUMMARY                          ${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    
    echo -e "\n${BLUE}Application Details:${NC}"
    echo "• Name: $APP_NAME"
    echo "• ID: $APPLICATION_ID"
    echo "• Status: ACTIVE"
    
    echo -e "\n${BLUE}Access Information:${NC}"
    echo "• Web Interface: $WEB_URL"
    echo "• AWS Console: https://us-east-1.console.aws.amazon.com/qbusiness/home?region=us-east-1#!/applications/$APPLICATION_ID"
    
    echo -e "\n${BLUE}Next Steps:${NC}"
    echo "1. Complete Q CLI authentication: q login --license free"
    echo "2. Access your web interface: $WEB_URL"
    echo "3. Configure IDE integration (VS Code, IntelliJ)"
    echo "4. Use your activation token in the web interface"
    
    echo -e "\n${YELLOW}Configuration saved to: amazon-q-config.json${NC}"
    
    # Save configuration
    cat > amazon-q-config.json << EOF
{
    "applicationName": "$APP_NAME",
    "applicationId": "$APPLICATION_ID",
    "applicationArn": "$APPLICATION_ARN",
    "webExperienceId": "$WEB_EXPERIENCE_ID",
    "webUrl": "$WEB_URL",
    "identityCenterArn": "$IDC_ARN",
    "builderId": "$BUILDER_ID",
    "awsAccount": "$ACCOUNT_ID",
    "setupDate": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF
}

# Cleanup function
cleanup() {
    if [ $? -ne 0 ]; then
        log_error "Setup failed. Check the error messages above."
        echo -e "\n${YELLOW}Troubleshooting tips:${NC}"
        echo "1. Verify your Identity Center ARN format"
        echo "2. Ensure your Builder ID is correct"
        echo "3. Check AWS permissions for Q Business operations"
        echo "4. Try running individual AWS CLI commands manually"
    fi
}

# Set trap for cleanup
trap cleanup EXIT

# Main execution
main() {
    check_prerequisites
    get_user_inputs
    create_application
    create_user
    create_web_experience
    configure_q_cli
    generate_summary
}

# Run main function
main "$@"
