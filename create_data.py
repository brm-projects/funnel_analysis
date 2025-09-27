import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import random
import os

# Parameters
n_users = 50  # adjust this number for bigger dataset
start_date = datetime(2025, 9, 20, 8, 0)

steps = [
    ("signup", 1),
    ("profile_completed", 2),
    ("kyc_passed", 3),
    ("first_payment", 4),
]

sources = ["ads", "organic", "partner"]
countries = ["FR", "PT", "BR"]

records = []

for user_id in range(1, n_users + 1):
    # each user has a funnel start time
    event_time = start_date + timedelta(minutes=random.randint(0, 1200))
    source = random.choice(sources)
    country = random.choice(countries)
    
    # simulate funnel progression (dropout possible)
    for step_name, step_num in steps:
        # random dropout: user may stop at any step
        if random.random() < 0.8:  # 80% chance to continue
            records.append([
                user_id,
                event_time.isoformat() + "Z",  # keep ISO8601 with Z
                step_name,
                step_num,
                source,
                country
            ])
            # next step happens within 1–60 minutes
            event_time += timedelta(minutes=random.randint(1, 60))
        else:
            break

# Create DataFrame
df = pd.DataFrame(records, columns=["user_id","event_time","event_name","step","source","country"])

# Make sure seeds folder exists
os.makedirs("seeds", exist_ok=True)

# Save to CSV
df.to_csv("seeds/events.csv", index=False)

print(f"Generated {len(df)} events for {n_users} users → seeds/events.csv")
