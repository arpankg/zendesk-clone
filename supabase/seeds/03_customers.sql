-- NEW CUSTOMERS (10 additional) -----------------------------------------------

-- Customer 6
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '733d23f0-5057-4737-8a70-656deee126be',
    'alice.martin@example.com',
    now() - interval '10 days',
    now() - interval '1 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.customers (
    id,
    first_name,
    last_name,
    communication_channels,
    preferred_language,
    email,
    feedback_history,
    created_at,
    updated_at
) VALUES (
    '733d23f0-5057-4737-8a70-656deee126be',
    'Alice',
    'Martin',
    ARRAY['web', 'email'],
    'en',
    'alice.martin@example.com',
    '{
      "feedback": []
    }'::jsonb,
    now() - interval '10 days',
    now() - interval '10 days'
);

-- Customer 7
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'b0a16a7f-b48b-4254-a7d7-fc5f79e3c263',
    'mehmet.ersoy@example.com',
    now() - interval '20 days',
    now() - interval '5 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.customers (
    id,
    first_name,
    last_name,
    communication_channels,
    preferred_language,
    email,
    feedback_history,
    created_at,
    updated_at
) VALUES (
    'b0a16a7f-b48b-4254-a7d7-fc5f79e3c263',
    'Mehmet',
    'Ersoy',
    ARRAY['chat', 'web', 'phone'],
    'tr',
    'mehmet.ersoy@example.com',
    '{
      "feedback": []
    }'::jsonb,
    now() - interval '20 days',
    now() - interval '20 days'
);

-- Customer 8
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '2f046dd1-cd22-4fca-a9d4-624b48b61b6d',
    'jun.kim@example.com',
    now() - interval '15 days',
    now() - interval '1 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.customers (
    id,
    first_name,
    last_name,
    communication_channels,
    preferred_language,
    email,
    feedback_history,
    created_at,
    updated_at
) VALUES (
    '2f046dd1-cd22-4fca-a9d4-624b48b61b6d',
    'Jun',
    'Kim',
    ARRAY['web', 'chat'],
    'ko',
    'jun.kim@example.com',
    '{
      "feedback": [
        {
          "rating": 4,
          "comment": "Good service, but language docs missing",
          "submitted_at": "2025-01-10T09:15:00Z",
          "ticket_id": "eb3f90ba-e2bb-4b68-9b79-d6cdf8abec2f"
        }
      ]
    }'::jsonb,
    now() - interval '15 days',
    now() - interval '15 days'
);
