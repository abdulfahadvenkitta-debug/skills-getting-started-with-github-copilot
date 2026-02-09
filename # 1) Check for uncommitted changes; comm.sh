# 1) Check for uncommitted changes; commit or stash
git status
git add -A
git commit -m "WIP: start accelerate-with-copilot"   # or: git stash

# 2) Update local main
git fetch origin
git checkout main
git pull origin main

# 3) Create & switch to the new branch
git checkout -b accelerate-with-copilot

# 4) Push and set upstream
git push -u origin accelerate-with-copilot

# 5) Verify
git branch          # shows local branches, current marked with *
git branch -r       # shows remote branches

gh pr create --fill

@app.post("/activities/{activity_name}/signup")
def signup_for_activity(activity_name: str, email: str):
    """Sign up a student for an activity"""
    if activity_name not in activities:
        raise HTTPException(status_code=404, detail="Activity not found")

    activity = activities[activity_name]

    # Normalize email for comparison
    email_norm = email.strip().lower()
    existing = [p.strip().lower() for p in activity.get("participants", [])]

    # Validate student is not already signed up
    if email_norm in existing:
        raise HTTPException(status_code=400, detail="Student is already signed up")

    # Optional: enforce capacity if provided
    max_p = activity.get("max_participants")
    if max_p is not None and len(activity.get("participants", [])) >= max_p:
        raise HTTPException(status_code=400, detail="Activity is full")

    activity.setdefault("participants", []).append(email_norm)
    return {"message": f"Signed up {email_norm} for {activity_name}"}

pip install -r requirements.txt
python -m uvicorn src.app:app --reload

curl -i -X POST "http://localhost:8000/activities/Chess%20Club/signup?email=michael@mergington.edu"
# Expect 400 with "Student is already signed up"

activities = {
    "Chess Club": {
        "description": "Learn strategies and compete in chess tournaments",
        "schedule": "Fridays, 3:30 PM - 5:00 PM",
        "max_participants": 12,
        "participants": ["michael@mergington.edu", "daniel@mergington.edu"]
    },
    "Programming Class": {
        "description": "Learn programming fundamentals and build software projects",
        "schedule": "Tuesdays and Thursdays, 3:30 PM - 4:30 PM",
        "max_participants": 20,
        "participants": ["emma@mergington.edu", "sophia@mergington.edu"]
    },
    "Gym Class": {
        "description": "Physical education and sports activities",
        "schedule": "Mondays, Wednesdays, Fridays, 2:00 PM - 3:00 PM",
        "max_participants": 30,
        "participants": ["john@mergington.edu", "olivia@mergington.edu"]
    },

    # Sports
    "Soccer Club": {
        "description": "Team training, scrimmages, and local matches",
        "schedule": "Wednesdays and Saturdays, 4:00 PM - 6:00 PM",
        "max_participants": 22,
        "participants": []
    },
    "Swimming Team": {
        "description": "Lap training, technique, and swim meets",
        "schedule": "Tuesdays and Thursdays, 5:00 PM - 6:30 PM",
        "max_participants": 18,
        "participants": []
    },

    # Artistic
    "Art Studio": {
        "description": "Drawing, painting, and portfolio development",
        "schedule": "Mondays, 3:30 PM - 5:00 PM",
        "max_participants": 15,
        "participants": []
    },
    "Drama Club": {
        "description": "Acting workshops and term plays",
        "schedule": "Fridays, 4:00 PM - 6:00 PM",
        "max_participants": 25,
        "participants": []
    },

    # Intellectual
    "Math Olympiad": {
        "description": "Problem solving practice and competition prep",
        "schedule": "Thursdays, 4:00 PM - 5:30 PM",
        "max_participants": 16,
        "participants": []
    },
    "Science Club": {
        "description": "Hands-on experiments and science fair projects",
        "schedule": "Wednesdays, 3:30 PM - 5:00 PM",
        "max_participants": 20,
        "participants": []
    }
}