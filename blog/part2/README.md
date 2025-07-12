# Amazon Q Developer - Part 2: Local Development Setup

![Development Workflow](../../images/multi-platform-workflow.svg)
*Amazon Q working across different development environments and tools*

Ready to level up your Amazon Q experience? In [Part 1](../part1/README.md), we got the free version working in VS Code. Now let's add command line superpowers and get the most out of your setup.

The CLI gives you flexibility that the VS Code extension can't match - batch processing, any editor support, and better context understanding.

## Why Install the CLI?

The VS Code extension is great, but the command line interface gives you superpowers:

**More flexibility:**
- Works with Vim, Emacs, or any editor
- Batch process multiple files
- Integrate with your existing scripts
- Better for large codebases

**Advanced features:**
- Chat sessions that remember context
- File analysis and recommendations
- Project-wide code reviews

## Installing on Windows

**Option 1: Direct Download**
1. Go to https://aws.amazon.com/q/
2. Download the Windows installer
3. Run the installer
4. Open Command Prompt or PowerShell

**Option 2: Package Manager (if you have winget)**
```powershell
winget install Amazon.Q
```

**Verify it worked:**
```powershell
q --version
```

**Sign in:**
```powershell
q auth login
```

This opens your browser. Sign in with the same Builder ID you used in VS Code.

## Installing on WSL (Recommended for Developers)

**Why WSL?** If you're doing serious development on Windows, WSL gives you the best of both worlds. Better terminal, Linux tools, but still Windows.

**Install Q in WSL:**
```bash
# Download the Linux version
curl -Lo q.zip https://d2yblsmsllhfto.cloudfront.net/q/latest/q-linux-x64.zip

# Extract and install
unzip q.zip
sudo mv q /usr/local/bin/
chmod +x /usr/local/bin/q

# Verify installation
q --version

# Sign in
q auth login
```

**Test your setup:**
```bash
# Start a chat session
q chat

# Try asking something
"How do I handle exceptions in Python?"

# Exit with Ctrl+C or type 'exit'
```

```
Block Diagram: Complete Amazon Q Setup

┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Development   │    │   Amazon Q      │    │   Your Machine  │
│   Environment   │    │   Service       │    │                 │
│                 │    │                 │    │                 │
│ ┌─────────────┐ │    │ ┌─────────────┐ │    │ ┌─────────────┐ │
│ │ VS Code     │ │◄──►│ │ AI Engine   │ │    │ │ Windows     │ │
│ │ Extension   │ │    │ │             │ │    │ │ Native      │ │
│ └─────────────┘ │    │ └─────────────┘ │    │ └─────────────┘ │
│                 │    │                 │    │                 │
│ ┌─────────────┐ │    │ ┌─────────────┐ │    │ ┌─────────────┐ │
│ │ Q CLI       │ │◄──►│ │ Code        │ │    │ │ WSL2        │ │
│ │ Terminal    │ │    │ │ Analysis    │ │    │ │ Linux       │ │
│ └─────────────┘ │    │ └─────────────┘ │    │ └─────────────┘ │
│                 │    │                 │    │                 │
│ ┌─────────────┐ │    │ ┌─────────────┐ │    │ ┌─────────────┐ │
│ │ Other IDEs  │ │◄──►│ │ Security    │ │    │ │ Builder ID  │ │
│ │ IntelliJ    │ │    │ │ Scanner     │ │    │ │ Profile     │ │
│ └─────────────┘ │    │ └─────────────┘ │    │ └─────────────┘ │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Getting the Most from CLI

**Interactive Chat:**
```bash
q chat
```
This starts a conversation where Q remembers context. Much better than one-off questions.

**File Analysis:**
```bash
# Analyze a specific file
q chat --file app.py "Review this code for potential issues"

# Multiple files
q chat --file *.py "Find common patterns across these files"
```

**Project-wide Help:**
```bash
# In your project directory
q chat "Analyze this entire project and suggest improvements"

# Generate documentation
q chat "Create a README file for this project"
```

## Real-World Examples

**Debugging Help:**
```bash
q chat "This Python script crashes with 'KeyError'. Here's the code: [paste your code]"
```

**Code Generation:**
```bash
q chat "Write a Python function that connects to PostgreSQL and handles connection errors gracefully"
```

**Learning New Libraries:**
```bash
q chat "Show me how to use pandas to read a CSV file and filter rows where column 'age' > 25"
```

**Code Review:**
```bash
q chat --file myapp.py "Review this code for security vulnerabilities and performance issues"
```

## Advanced Workflows

### Multi-File Analysis

```bash
# Analyze entire project structure
q chat "Review all Python files in this project for consistency and best practices"

# Compare implementations
q chat --file old_version.py --file new_version.py "Compare these implementations and suggest improvements"
```

### Documentation Generation

```bash
# Generate project documentation
q chat "Create comprehensive documentation for this codebase including setup instructions and API reference"

# Generate docstrings
q chat --file utils.py "Add proper docstrings to all functions in this file"
```

### Testing and Quality Assurance

```bash
# Generate test cases
q chat --file calculator.py "Generate comprehensive unit tests for all functions in this file"

# Security analysis
q chat "Perform a security audit of this web application code"
```

## Integration with Development Workflow

### Git Integration

```bash
# Before committing
q chat --file $(git diff --name-only) "Review these changed files for potential issues"

# Commit message generation
q chat "Generate a good commit message for these changes: $(git diff --cached)"
```

### CI/CD Integration

```bash
# In your build scripts
q chat --file src/ "Analyze code quality and suggest improvements before deployment"
```

## Troubleshooting Advanced Issues

**"Command 'q' not found" (WSL)**
- Check the file is executable: `chmod +x /usr/local/bin/q`
- Verify it's in your PATH: `echo $PATH`
- Try: `which q` to see if it's found

**"Slow responses"**
- Check your internet connection
- Try smaller code snippets
- Some complex requests take longer

**"Context not remembered"**
- Make sure you're using `q chat` (interactive mode)
- Each new `q chat` command starts fresh
- Use one session for related questions

**"File analysis not working"**
- Check file permissions
- Make sure file paths are correct
- Try absolute paths if relative paths fail

## Performance Tips

**For Large Codebases:**
- Use specific file targeting instead of analyzing everything
- Break complex questions into smaller parts
- Use project-specific context in your questions

**For Better Responses:**
- Provide context about your tech stack
- Be specific about what you're trying to achieve
- Include relevant error messages or requirements

## What's Next?

You now have:
- Amazon Q working in your IDE (from Part 1)
- Command line access for advanced features
- Understanding of both free capabilities

**Ready for Pro features?** The next parts will cover:
- When and how to upgrade to Amazon Q Developer Pro
- Advanced agentic AI with multiple specialized agents
- Enterprise features and team collaboration

## Quick Reference

**Essential Commands:**
```bash
q auth login          # Sign in
q auth logout         # Sign out
q chat               # Start interactive session
q chat --file app.py # Analyze specific file
q --help             # Get help
```

**Best Practices:**
- Use interactive mode (`q chat`) for related questions
- Be specific about your programming language and framework
- Include error messages and context in your questions
- Test generated code before using in production

## The Complete Setup

At this point, you have a complete Amazon Q development environment:

**✅ IDE Integration:** Real-time suggestions and chat
**✅ Command Line Power:** Batch processing and advanced analysis  
**✅ Cross-Platform:** Works on Windows, WSL, and Linux
**✅ Flexible Workflow:** Fits into any development process

The free version gives you professional-grade AI assistance for coding. Most developers find this setup handles 90% of their AI-assisted development needs.

---

**Previous:** [Part 1: Foundation & Free Version](../part1/README.md)  
**Next:** Part 3: Upgrading to Pro (Coming Soon)
