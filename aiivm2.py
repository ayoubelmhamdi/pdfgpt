#!/bin/env python3

import cloudscraper

scraper = cloudscraper.create_scraper()  # returns a CloudScraper instance

def ask_gpt4(user=None, admin=None):
    json_data = {
        "model": {'id': 'gpt-4', 'name': 'GPT-4'},
        "messages": [{"role": "user", "content": user}],
        "key": "",
        "prompt": admin,
        "temperature": 0.7,
    }
    
    response = scraper.post(
        "https://chat.aivvm.com/api/chat",
        json=json_data,
    )
