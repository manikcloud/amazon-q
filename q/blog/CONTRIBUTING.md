# Contributing to Amazon Q Developer Pro Setup Guide

First off, thank you for considering contributing to this project! 🎉

This guide has helped many developers successfully set up Amazon Q Developer Pro, and your contributions can help even more people overcome the setup challenges.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Getting Started](#getting-started)
- [Development Process](#development-process)
- [Style Guidelines](#style-guidelines)
- [Commit Guidelines](#commit-guidelines)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

This project adheres to a code of conduct that we expect all contributors to follow. Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## How Can I Contribute?

### 🐛 Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When creating a bug report, include:

- **Clear title** describing the issue
- **Detailed description** of the problem
- **Steps to reproduce** the issue
- **Expected vs actual behavior**
- **Environment details** (OS, AWS CLI version, Q CLI version)
- **Screenshots or logs** if applicable

**Bug Report Template:**
```markdown
## Bug Description
Brief description of the bug

## Steps to Reproduce
1. Step one
2. Step two
3. Step three

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- OS: [e.g., macOS 12.0, Ubuntu 20.04]
- AWS CLI Version: [e.g., 2.7.0]
- Q CLI Version: [e.g., 1.0.0]
- Region: [e.g., us-east-1]

## Additional Context
Any other relevant information
```

### 💡 Suggesting Enhancements

Enhancement suggestions are welcome! Please provide:

- **Clear title** for the enhancement
- **Detailed description** of the proposed feature
- **Use case** explaining why this would be useful
- **Implementation ideas** if you have any

### 📝 Improving Documentation

Documentation improvements are always appreciated:

- Fix typos or grammatical errors
- Clarify confusing sections
- Add missing information
- Improve code examples
- Add troubleshooting scenarios

### 🔧 Contributing Code

We welcome code contributions including:

- Bug fixes
- New features
- Performance improvements
- Test coverage improvements
- Automation scripts

## Getting Started

### Prerequisites

- Git installed on your machine
- AWS CLI configured
- Q CLI installed
- Basic knowledge of AWS services
- Familiarity with Markdown

### Fork and Clone

1. **Fork** the repository on GitHub
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/amazon-q.git
   cd amazon-q
   ```
3. **Add upstream** remote:
   ```bash
   git remote add upstream https://github.com/manikcloud/amazon-q.git
   ```

### Development Setup

1. **Create a branch** for your work:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following our style guidelines

3. **Test your changes** thoroughly:
   ```bash
   # Test setup script
   ./scripts/setup-amazon-q.sh --dry-run
   
   # Validate documentation
   markdownlint README.md
   ```

## Development Process

### Branch Naming Convention

Use descriptive branch names:
- `feature/add-multi-region-support`
- `bugfix/fix-identity-center-arn-validation`
- `docs/improve-troubleshooting-section`
- `enhancement/add-automated-testing`

### Making Changes

1. **Keep changes focused** - one feature/fix per PR
2. **Write clear commit messages** following our guidelines
3. **Update documentation** if needed
4. **Add tests** for new functionality
5. **Ensure backward compatibility** when possible

### Testing

Before submitting your changes:

1. **Test the setup script** with different configurations
2. **Validate all documentation links**
3. **Check markdown formatting**
4. **Verify code examples work**

```bash
# Run tests
./scripts/test-setup.sh

# Validate markdown
markdownlint *.md

# Check links
markdown-link-check README.md
```

## Style Guidelines

### Documentation Style

- Use **clear, concise language**
- Include **code examples** for complex concepts
- Add **screenshots** for UI-related instructions
- Use **consistent formatting** throughout
- Follow **GitHub Markdown** conventions

### Code Style

- Use **meaningful variable names**
- Add **comments** for complex logic
- Follow **shell scripting best practices**
- Include **error handling**
- Use **consistent indentation** (2 spaces)

### Markdown Formatting

```markdown
# Main Headers (H1)
## Section Headers (H2)
### Subsection Headers (H3)

**Bold text** for emphasis
*Italic text* for subtle emphasis
`Code snippets` for commands/code
```

### Code Blocks

Use appropriate language tags:

```bash
# Shell commands
aws sts get-caller-identity
```

```json
{
  "example": "JSON response"
}
```

```yaml
# YAML configuration
key: value
```

## Commit Guidelines

### Commit Message Format

```
type(scope): brief description

Detailed explanation of the change (if needed)

Fixes #issue-number
```

### Commit Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples

```
feat(setup): add multi-region support for Q Business applications

- Add region selection in setup script
- Update documentation with region considerations
- Add validation for supported regions

Fixes #123
```

```
docs(readme): improve troubleshooting section

- Add common Identity Center issues
- Include more detailed error messages
- Add links to AWS documentation

Closes #456
```

## Pull Request Process

### Before Submitting

1. **Sync with upstream**:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run final tests**:
   ```bash
   ./scripts/test-setup.sh
   markdownlint *.md
   ```

3. **Update documentation** if needed

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Other (please describe)

## Testing
- [ ] Tested setup script
- [ ] Validated documentation
- [ ] Checked all links
- [ ] Verified examples work

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)

## Related Issues
Fixes #issue-number
```

### Review Process

1. **Automated checks** must pass
2. **At least one maintainer** review required
3. **Address feedback** promptly
4. **Squash commits** if requested
5. **Maintainer will merge** when approved

## Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes for significant contributions
- GitHub contributors page

## Questions?

- 💬 **GitHub Discussions**: Ask questions
- 📧 **Email**: Contact maintainers
- 🐛 **Issues**: Report problems

## Thank You!

Your contributions make this project better for everyone. Whether it's a typo fix, a new feature, or helping other users in discussions - every contribution matters! 🙏

---

*This contributing guide is inspired by open source best practices and tailored for our Amazon Q setup project.*
