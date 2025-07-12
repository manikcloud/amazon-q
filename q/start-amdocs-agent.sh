#!/bin/bash

echo "🚀 STARTING AMDOCS TROUBLESHOOTING AGENT ULTRA"
echo "=============================================="
echo ""

# Check if pods are running
echo "1. Checking system status..."
PODS_READY=$(kubectl get pods -n amdocs-ultra-simple --no-headers | grep "1/1.*Running" | wc -l)
echo "   Pods ready: $PODS_READY/7"

if [ $PODS_READY -lt 5 ]; then
    echo "   ⚠️  Some pods are not ready. Waiting..."
    kubectl wait --for=condition=ready pod -l app=amdocs-ultra-simple-backend -n amdocs-ultra-simple --timeout=60s
fi

echo ""
echo "2. Setting up port forwarding for reliable access..."
echo "   Backend: localhost:8080 -> backend service"
echo "   Frontend: localhost:32101 (already available)"

# Kill any existing port forwarding
pkill -f "kubectl port-forward.*amdocs-ultra-simple.*8080" 2>/dev/null

# Start port forwarding in background
kubectl port-forward -n amdocs-ultra-simple service/amdocs-ultra-simple-backend-service 8080:8000 &
PF_PID=$!

echo "   Port forwarding PID: $PF_PID"
echo ""

# Wait for connection
echo "3. Testing connections..."
sleep 5

# Test backend
if curl -s --max-time 10 http://localhost:8080/health | grep -q "healthy"; then
    echo "   ✅ Backend: http://localhost:8080 (WORKING)"
else
    echo "   ⚠️  Backend: http://localhost:8080 (STARTING...)"
fi

# Test frontend
if curl -s --max-time 5 http://localhost:32101/ | grep -q "Amdocs"; then
    echo "   ✅ Frontend: http://localhost:32101 (WORKING)"
else
    echo "   ⚠️  Frontend: http://localhost:32101 (CHECK MANUALLY)"
fi

echo ""
echo "🎯 ACCESS YOUR AMDOCS TROUBLESHOOTING AGENT:"
echo "==========================================="
echo "🌐 Frontend Interface: http://localhost:32101"
echo "⚡ Backend API:        http://localhost:8080"
echo "📊 Health Check:       http://localhost:8080/health"
echo "📈 Performance Stats:  http://localhost:8080/performance"
echo ""
echo "🔧 USAGE INSTRUCTIONS:"
echo "======================"
echo "1. Open your browser and go to: http://localhost:32101"
echo "2. The interface will automatically connect to the backend"
echo "3. Try example questions or ask your own AWS troubleshooting questions"
echo "4. Enjoy ultra-fast responses with professional Amdocs branding!"
echo ""
echo "⚠️  IMPORTANT: Keep this terminal open to maintain the connection"
echo "   To stop: Press Ctrl+C or run: kill $PF_PID"
echo ""
echo "🏢 Amdocs Troubleshooting Agent Ultra Performance Edition v2.0.0"
echo "© 2024 Amdocs. All rights reserved."
echo "Created by Varun Kumar, AWS Ambassador"
echo "Under guidance of Vineet Saxena, Head of PSU-IT"
echo ""

# Keep the script running to maintain port forwarding
echo "✅ System is ready! Port forwarding is active..."
echo "   Press Ctrl+C to stop the service"

# Wait for user interrupt
trap 'echo ""; echo "🛑 Stopping Amdocs Troubleshooting Agent..."; kill $PF_PID 2>/dev/null; echo "✅ Stopped successfully"; exit 0' INT

# Keep running
while true; do
    sleep 30
    # Check if port forwarding is still running
    if ! kill -0 $PF_PID 2>/dev/null; then
        echo "⚠️  Port forwarding stopped. Restarting..."
        kubectl port-forward -n amdocs-ultra-simple service/amdocs-ultra-simple-backend-service 8080:8000 &
        PF_PID=$!
        echo "   New PID: $PF_PID"
    fi
done
