#!/bin/env python3

from __future__ import annotations
import requests


def get_ai_response(admin: str | None, user: str | None) -> str:
    if admin is None:
        raise ValueError("admin rull is None")
    if user is None:
        raise ValueError("user message is None")

    headers = {
        "accept": "*/*",
        "accept-language": "hu-HU,hu;q=0.9,en-US;q=0.8,en;q=0.7",
        "content-type": "application/json",
        "sec-ch-ua": '"Kuki";v="116", "Not)A;Brand";v="24", "Pici Pocoro";v="102"',
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": '"Bandóz"',
        "sec-fetch-dest": "empty",
        "sec-fetch-mode": "cors",
        "sec-fetch-site": "same-origin",
        "Referer": "https://chat.aivvm.com/",
        "Referrer-Policy": "same-origin",
    }

    json_data = {
        "model": {'id': 'gpt-4', 'name': 'GPT-4'},
        "messages": [{"role": "user", "content": user}],
        "key": "",
        "prompt": admin,
        "temperature": 0.7,  # You can adjust this value if needed
    }

    response = requests.post(
        "https://chat.aivvm.com/api/chat",
        headers=headers,
        json=json_data,
    )
    # help(response)
    return response.text


text = get_ai_response(admin="You are chatGPT", user="calcluer 1+9")
print(text)
