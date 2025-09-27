import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random

# Parameters
n_users = 1000
start_date = datetime(2025, 1, 1)

steps = ["signup", "profile_completed", "kyc_passed", "first_payment"]
sources = ["ads", "organic", "referral"]

rows = []

for user_id in range(1, n_users + 1):
    # each user gets a random source
    source = random.choice(sources)

    # each user signs up at some random time
    event_time = start_date + timedelta(minutes=random.randint(0, 60*24*30))  # within 30 days
    rows.append([user_id, "signup", event_time.isoformat(), source])

    # chance to complete further steps
    for step in steps[1:]:
        if random.random() < 0.8:  # 80% chance to move to next step
            event_time += timedelta(minutes=random.randint(10, 1440))  # within 1 day after last
            rows.append([user_id, step, event_time.isoformat(), source])
        else:
            break

# Build DataFrame
df = pd.DataFrame(rows, columns=["user_id", "event_name", "event_time", "source"])

# Save as CSV in seeds folder
df.to_csv("seeds/events.csv", index=False)
print("✅ Generated dataset with", len(df), "rows")
