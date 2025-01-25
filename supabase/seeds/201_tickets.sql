-- Sample ticket data for the support system
-- Includes various statuses, priorities, and ticket types

--------------------------------------------------------------------------------
-- Ticket 1: New ticket from Test User
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    'c0d3b4e5-f6a7-4b8c-9d0e-1a2b3c4d5e6f',
    'Cannot access dashboard',
    'I am unable to access my dashboard after logging in. The page shows a blank screen.',
    'new',
    'high',
    ARRAY['login', 'dashboard', 'access'],
    '{}',
    '{
        "events": [
            {
                "id": "550e8400-e29b-41d4-a716-446655440000",
                "type": "message",
                "content": "I am unable to access my dashboard after logging in",
                "created_at": "2024-12-20T14:25:00Z",
                "created_by_uuid": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "created_by_first_name": "Test",
                "created_by_last_name": "User",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440001",
                "type": "message",
                "content": "Hi! I''m sorry you''re having trouble accessing your dashboard. Could you please try clearing your browser cache and cookies, then logging in again?",
                "created_at": "2024-12-20T14:30:00Z",
                "created_by_uuid": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Johnson",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440002",
                "type": "message",
                "content": "I''ll try that now and let you know if it works.",
                "created_at": "2024-12-20T14:32:00Z",
                "created_by_uuid": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "created_by_first_name": "Test",
                "created_by_last_name": "User",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440003",
                "type": "status-update",
                "old_value": "new",
                "new_value": "open",
                "created_at": "2024-12-20T14:33:00Z",
                "created_by_uuid": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Johnson",
                "visibility": "public"
            },
            {
                "id": "0213491b-6b7e-4aac-8fcc-3850393346eb",
                "type": "message",
                "content": "I cleared cache and cookies, but the issue remains.",
                "created_at": "2024-12-20T14:34:00Z",
                "created_by_uuid": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58",
                "created_by_first_name": "Test",
                "created_by_last_name": "User",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "aad66112-4743-4bc7-8107-7dfe373f97f2",
                "type": "message",
                "content": "Thanks for confirming. Could you also try a different browser and let us know the result?",
                "created_at": "2024-12-20T14:36:00Z",
                "created_by_uuid": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Johnson",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "be33c132-38bf-4ef0-a387-ae8b3ffc7b92",
                "type": "status-update",
                "old_value": "open",
                "new_value": "pending",
                "created_at": "2024-12-20T14:40:00Z",
                "created_by_uuid": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Johnson",
                "visibility": "public"
            },
            {
                "id": "708bb0d1-6432-46a3-bcfe-4762205fd43a",
                "type": "field-added",
                "field_name": "browser_info",
                "new_value": "Chrome v108",
                "created_at": "2024-12-20T14:42:00Z",
                "created_by_uuid": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Johnson",
                "visibility": "private"
            }
        ]
    }'::jsonb,
    '{
        "notes": [
            {
                "id": "f8a074ca-4e56-4a85-b61d-5b9947bf5c29",
                "content": "User has tried clearing cache; issue persists.",
                "created_at": "2024-12-20T14:35:00Z",
                "created_by": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8"
            },
            {
                "id": "b4a23044-2618-4e27-9983-b941ebc210cd",
                "content": "Potential JS error in the dashboard. Need to escalate if user can reproduce in multiple browsers.",
                "created_at": "2024-12-20T14:37:00Z",
                "created_by": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8"
            }
        ]
    }'::jsonb,
    '{"rating": 0, "comment": "", "submitted_at": null}'::jsonb,
    'web',
    now(),
    now(),
    '5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58',
    'test@gmail.com',
    '[]'::jsonb
);

--------------------------------------------------------------------------------
-- Ticket 2: Closed ticket with feedback from Sarah Miller
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    '7e8f9a0b-c1d2-4e3f-a4b5-6c7d8e9f0a1b',
    'Billing inquiry about premium plan',
    'I have some questions about the premium plan pricing and features.',
    'closed',
    'medium',
    ARRAY['billing', 'premium', 'pricing'],
    '{"plan_type": "premium", "billing_cycle": "annual"}',
    '{
        "events": [
            {
                "id": "550e8400-e29b-41d4-a716-446655440004",
                "type": "message",
                "content": "I have questions about premium plan pricing",
                "created_at": "2024-12-15T09:00:00Z",
                "created_by_uuid": "f23c5c88-2322-4c2d-9f59-43e79a9b5c44",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Miller",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440005",
                "type": "message",
                "content": "Hi Sarah! I''d be happy to help explain our premium plan pricing. What specific information would you like to know?",
                "created_at": "2024-12-15T09:10:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440006",
                "type": "assignment-added",
                "agent_id": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_at": "2024-12-15T09:10:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "public"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440007",
                "type": "field-added",
                "field_name": "plan_type",
                "new_value": "premium",
                "created_at": "2024-12-15T09:11:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "private"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440008",
                "type": "message",
                "content": "I''m interested in annual billing. What kind of discount do you offer compared to monthly?",
                "created_at": "2024-12-15T09:12:00Z",
                "created_by_uuid": "f23c5c88-2322-4c2d-9f59-43e79a9b5c44",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Miller",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440009",
                "type": "message",
                "content": "With annual billing, you get a 20% discount compared to monthly billing. For the premium plan, that would be $1,200/year instead of $1,500 ($125/month).",
                "created_at": "2024-12-15T09:14:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440010",
                "type": "field-added",
                "field_name": "billing_cycle",
                "new_value": "annual",
                "created_at": "2024-12-15T09:16:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "private"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440011",
                "type": "status-update",
                "old_value": "open",
                "new_value": "closed",
                "created_at": "2024-12-15T09:18:00Z",
                "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
                "created_by_first_name": "Lisa",
                "created_by_last_name": "Brown",
                "visibility": "public"
            },
            {
                "id": "b111f1cb-a646-4e06-b967-52c4fe0abc69",
                "type": "message",
                "content": "Thank you, that clarifies everything. I have all I need now!",
                "created_at": "2024-12-15T09:19:00Z",
                "created_by_uuid": "f23c5c88-2322-4c2d-9f59-43e79a9b5c44",
                "created_by_first_name": "Sarah",
                "created_by_last_name": "Miller",
                "visibility": "public",
                "attachments": []
            }
        ]
    }'::jsonb,
    '{
        "notes": [
            {
                "id": "note1",
                "content": "Customer interested in annual plan",
                "created_at": "2024-12-15T09:12:00Z",
                "created_by": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f"
            },
            {
                "id": "34bc6a86-3386-4cc1-9acf-c4877d803fa9",
                "content": "All billing questions answered; customer closed ticket themselves after inquiry.",
                "created_at": "2024-12-15T09:20:00Z",
                "created_by": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f"
            }
        ]
    }'::jsonb,
    '{
        "rating": 4,
        "comment": "Quick response, but needed follow-up",
        "submitted_at": "2024-12-15T09:15:00Z"
    }'::jsonb,
    'chat',
    now() - interval '5 days',
    now() - interval '5 days',
    'f23c5c88-2322-4c2d-9f59-43e79a9b5c44',
    'sarah.miller@example.com',
    '[]'::jsonb
);

--------------------------------------------------------------------------------
-- Ticket 3: Pending ticket from Carlos Garcia
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    '2b3c4d5e-f6a7-8b9c-0d1e-2f3a4b5c6d7e',
    'Problema con la configuración de idioma',
    E'El sistema no guarda mi preferencia de idioma español.',
    'pending',
    'low',
    ARRAY['language', 'settings', 'spanish'],
    '{"preferred_language": "es"}',
    '{
        "events": [
            {
                "id": "550e8400-e29b-41d4-a716-446655440012",
                "type": "message",
                "content": "El sistema no guarda mi preferencia de idioma español.",
                "created_at": "2024-12-10T10:00:00Z",
                "created_by_uuid": "7d3e41c9-9a5d-4e4f-a71c-94b17e8f6e24",
                "created_by_first_name": "Carlos",
                "created_by_last_name": "Garcia",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440013",
                "type": "assignment-added",
                "agent_id": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
                "created_at": "2024-12-10T10:05:00Z",
                "created_by_uuid": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
                "created_by_first_name": "James",
                "created_by_last_name": "Martinez",
                "visibility": "public"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440014",
                "type": "field-added",
                "field_name": "language",
                "new_value": "es",
                "created_at": "2024-12-10T10:06:00Z",
                "created_by_uuid": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
                "created_by_first_name": "James",
                "created_by_last_name": "Martinez",
                "visibility": "private"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440015",
                "type": "status-update",
                "old_value": "new",
                "new_value": "pending",
                "created_at": "2024-12-10T10:07:00Z",
                "created_by_uuid": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
                "created_by_first_name": "James",
                "created_by_last_name": "Martinez",
                "visibility": "public"
            },
            {
                "id": "70532159-c3d7-4ce9-a836-72acdfa2a8c5",
                "type": "message",
                "content": "He intentado configurar el idioma varias veces. ¿Hay alguna otra forma de forzar la preferencia?",
                "created_at": "2024-12-10T10:10:00Z",
                "created_by_uuid": "7d3e41c9-9a5d-4e4f-a71c-94b17e8f6e24",
                "created_by_first_name": "Carlos",
                "created_by_last_name": "Garcia",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "b32d8fc7-188a-4a2f-9f75-ea22dac795d3",
                "type": "message",
                "content": "Hola Carlos, estamos revisando tu configuración ahora. Es posible que tengamos que actualizar tu perfil manualmente.",
                "created_at": "2024-12-10T10:12:00Z",
                "created_by_uuid": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
                "created_by_first_name": "James",
                "created_by_last_name": "Martinez",
                "visibility": "public",
                "attachments": []
            }
        ]
    }'::jsonb,
    '{
        "notes": [
            {
                "id": "note2",
                "content": "User experiencing persistent language setting issues",
                "created_at": "2024-12-10T10:07:00Z",
                "created_by": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab"
            },
            {
                "id": "d34653ce-9685-45cd-8cd1-d4a6d21e8446",
                "content": "Might require manual DB update or code fix for language settings bug.",
                "created_at": "2024-12-10T10:12:00Z",
                "created_by": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab"
            }
        ]
    }'::jsonb,
    '{
        "rating": 3,
        "comment": "Servicio regular, problemas de idioma",
        "submitted_at": "2024-12-10T10:08:00Z"
    }'::jsonb,
    'email',
    now() - interval '54 days',
    now() - interval '54 days',
    '7d3e41c9-9a5d-4e4f-a71c-94b17e8f6e24',
    'carlos.garcia@example.com',
    '[]'::jsonb
);

--------------------------------------------------------------------------------
-- Ticket 4: Open ticket from John Doe
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    '9a0b1c2d-3e4f-5a6b-7c8d-9e0f1a2b3c4d',
    'Need help with API integration',
    'Looking for documentation about API integration with your service.',
    'open',
    'medium',
    ARRAY['api', 'integration', 'documentation'],
    '{}',
    '{
        "events": [
            {
                "id": "550e8400-e29b-41d4-a716-446655440016",
                "type": "message",
                "content": "Need help finding API documentation",
                "created_at": "2024-01-20T10:00:00Z",
                "created_by_uuid": "a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f",
                "created_by_first_name": "John",
                "created_by_last_name": "Doe",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440017",
                "type": "message",
                "content": "Hi John! You can find our API documentation at docs.example.com/api. Is there a specific endpoint you''re looking for?",
                "created_at": "2024-01-20T10:05:00Z",
                "created_by_uuid": "7a1b5e4c-2d3f-6789-9012-1a2b3c4d5e6f",
                "created_by_first_name": "Alex",
                "created_by_last_name": "Chen",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440018",
                "type": "message",
                "content": "Yes, I''m specifically looking for the user management endpoints.",
                "created_at": "2024-01-20T10:07:00Z",
                "created_by_uuid": "a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f",
                "created_by_first_name": "John",
                "created_by_last_name": "Doe",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "a5481562-8d8f-420b-a008-8acbcfd9fe57",
                "type": "message",
                "content": "Thanks, I found the docs but need an example of how to create a user via the API.",
                "created_at": "2024-01-20T10:09:00Z",
                "created_by_uuid": "a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f",
                "created_by_first_name": "John",
                "created_by_last_name": "Doe",
                "visibility": "public",
                "attachments": []
            }
        ]
    }'::jsonb,
    '{
        "notes": [
            {
                "id": "9664c658-74bc-41bb-a6db-fb1a7ad47ec9",
                "content": "Might need to provide a sample cURL request with JSON body for user creation.",
                "created_at": "2024-01-20T10:10:00Z",
                "created_by": "7a1b5e4c-2d3f-6789-9012-1a2b3c4d5e6f"
            }
        ]
    }'::jsonb,
    '{"rating": 0, "comment": "", "submitted_at": null}'::jsonb,
    'web',
    now() - interval '1 day',
    now() - interval '1 day',
    'a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f',
    'john.doe@example.com',
    '[]'::jsonb
);

--------------------------------------------------------------------------------
-- Ticket 5: Complex ticket from Emma Wilson
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    '4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a',
    'Feature request: Enhanced reporting',
    'Would love to see more detailed analytics in the reporting dashboard.',
    'closed',
    'low',
    ARRAY['feature-request', 'analytics', 'reporting'],
    '{"feature_category": "analytics", "user_type": "premium"}',
    '{
        "events": [
            {
                "id": "550e8400-e29b-41d4-a716-446655440019",
                "type": "message",
                "content": "Hi! I''d love to see more detailed analytics in the reporting dashboard. Specifically, we need better insights into user engagement patterns and custom event tracking.",
                "created_at": "2024-12-10T13:30:00Z",
                "created_by_uuid": "b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9",
                "created_by_first_name": "Emma",
                "created_by_last_name": "Wilson",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440020",
                "type": "message",
                "content": "Hi Emma! Thank you for the suggestion. Could you tell us more about the specific metrics you''d like to track?",
                "created_at": "2024-12-10T13:35:00Z",
                "created_by_uuid": "2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d",
                "created_by_first_name": "Mike",
                "created_by_last_name": "Williams",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440021",
                "type": "message",
                "content": "We''d like to track user session duration, conversion funnels, and feature adoption rates. It would be great to see how different features correlate with user engagement.",
                "created_at": "2024-12-10T13:38:00Z",
                "created_by_uuid": "b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9",
                "created_by_first_name": "Emma",
                "created_by_last_name": "Wilson",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440022",
                "type": "status-update",
                "old_value": "new",
                "new_value": "open",
                "created_at": "2024-12-10T13:40:00Z",
                "created_by_uuid": "2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d",
                "created_by_first_name": "Mike",
                "created_by_last_name": "Williams",
                "visibility": "public"
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440023",
                "type": "message",
                "content": "Great feedback! I''m happy to share that these features are already on our Q1 2024 roadmap. Would you be interested in joining our beta testing program?",
                "created_at": "2024-12-10T13:42:00Z",
                "created_by_uuid": "2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d",
                "created_by_first_name": "Mike",
                "created_by_last_name": "Williams",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440024",
                "type": "message",
                "content": "Yes, definitely! Please add me to the beta testing group.",
                "created_at": "2024-12-10T13:43:00Z",
                "created_by_uuid": "b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9",
                "created_by_first_name": "Emma",
                "created_by_last_name": "Wilson",
                "visibility": "public",
                "attachments": []
            },
            {
                "id": "550e8400-e29b-41d4-a716-446655440025",
                "type": "status-update",
                "old_value": "open",
                "new_value": "closed",
                "created_at": "2024-12-10T13:45:00Z",
                "created_by_uuid": "2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d",
                "created_by_first_name": "Mike",
                "created_by_last_name": "Williams",
                "visibility": "public"
            },
            {
                "id": "07f98f21-fc55-4d7f-a2c1-04913e8b90e9",
                "type": "message",
                "content": "Thanks for closing the loop! Please keep me posted on the beta progress.",
                "created_at": "2024-12-10T13:46:00Z",
                "created_by_uuid": "b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9",
                "created_by_first_name": "Emma",
                "created_by_last_name": "Wilson",
                "visibility": "public",
                "attachments": []
            }
        ]
    }'::jsonb,
    '{
        "notes": [
            {
                "id": "note3",
                "content": "Valid feature request - added to product backlog",
                "created_at": "2024-12-10T13:42:00Z",
                "created_by": "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58"
            },
            {
                "id": "d15d3e1d-7191-46af-8ef9-b856ef891e1f",
                "content": "Emma has opted into beta testing. Follow up in Q1 2024.",
                "created_at": "2024-12-10T13:47:00Z",
                "created_by": "2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d"
            }
        ]
    }'::jsonb,
    '{
        "rating": 5,
        "comment": "Very helpful team",
        "submitted_at": "2024-12-10T13:45:00Z"
    }'::jsonb,
    'web',
    now() - interval '42 days',
    now() - interval '42 days',
    'b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9',
    'emma.wilson@example.com',
    '[]'::jsonb
);

--------------------------------------------------------------------------------
-- Ticket 6
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    '139e729e-5a32-4894-9c1f-afce9d148dc3',
    'Payment not processed',
    'My card was charged but the payment is not reflected in my account.',
    'open',
    'high',
    ARRAY['billing', 'payment'],
    '{"payment_method": "credit_card"}',
    '{
      "events": [
        {
          "id": "ed3f939e-3672-44ea-bdcf-a9987684b100",
          "type": "message",
          "content": "My credit card was charged but I don''t see an update on the invoice.",
          "created_at": "2025-01-05T11:00:00Z",
          "created_by_uuid": "6f46bb43-1913-4bd0-8489-3f8c8575f633",
          "created_by_first_name": "Aarav",
          "created_by_last_name": "Patel",
          "visibility": "public",
          "attachments": []
        },
        {
          "id": "68aed93f-cbc9-4ef9-a374-e5f7c65b390c",
          "type": "assignment-added",
          "agent_id": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
          "created_at": "2025-01-05T11:05:00Z",
          "created_by_uuid": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
          "created_by_first_name": "James",
          "created_by_last_name": "Martinez",
          "visibility": "public"
        },
        {
          "id": "ac9c0db2-90e7-48bc-8ad0-ffca463d7d48",
          "type": "message",
          "content": "I see that the charge was made on your card. Checking the system logs now.",
          "created_at": "2025-01-05T11:10:00Z",
          "created_by_uuid": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f",
          "created_by_first_name": "Lisa",
          "created_by_last_name": "Brown",
          "visibility": "public",
          "attachments": []
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "af2c1da2-ec18-47db-b25f-145dc951f7d9",
          "content": "Possibility of a delayed payment gateway update.",
          "created_at": "2025-01-05T11:06:00Z",
          "created_by": "4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f"
        }
      ]
    }'::jsonb,
    '{
      "rating": 2,
      "comment": "Response took too long",
      "submitted_at": "2025-01-05T11:00:00Z"
    }'::jsonb,
    'email',
    now() - interval '17 days',
    now() - interval '17 days',
    '6f46bb43-1913-4bd0-8489-3f8c8575f633',
    'aarav.patel@example.com',
    '[]'::jsonb
);

--------------------------------------------------------------------------------
-- Ticket 7
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    'eb3f90ba-e2bb-4b68-9b79-d6cdf8abec2f',
    'Korean language pack issue',
    'Some UI elements do not display properly in Korean.',
    'new',
    'medium',
    ARRAY['language', 'ui'],
    '{"language": "ko"}',
    '{
      "events": [
        {
          "id": "c60f29a6-88b2-4a21-81ab-bbf798ea61b3",
          "type": "message",
          "content": "UI elements are showing strange characters when I set the language to Korean.",
          "created_at": "2025-01-10T09:10:00Z",
          "created_by_uuid": "2f046dd1-cd22-4fca-a9d4-624b48b61b6d",
          "created_by_first_name": "Jun",
          "created_by_last_name": "Kim",
          "visibility": "public",
          "attachments": []
        },
        {
          "id": "0e5657a0-075f-496e-854e-4e7c26a7b31e",
          "type": "message",
          "content": "We are investigating if any fonts are missing on your device. Could you confirm your OS version?",
          "created_at": "2025-01-10T09:13:00Z",
          "created_by_uuid": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8",
          "created_by_first_name": "Sarah",
          "created_by_last_name": "Johnson",
          "visibility": "public",
          "attachments": []
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "nt-859",
          "content": "Possible encoding issue with Ko fonts",
          "created_at": "2025-01-10T09:12:00Z",
          "created_by": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8"
        },
        {
          "id": "e58c94bc-dd44-4816-a04e-293781c572ac",
          "content": "Might need a patch for full Hangul support.",
          "created_at": "2025-01-10T09:15:00Z",
          "created_by": "98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8"
        }
      ]
    }'::jsonb,
    '{
      "rating": 4,
      "comment": "Good service, but language docs missing",
      "submitted_at": "2025-01-10T09:15:00Z"
    }'::jsonb,
    'web',
    now() - interval '12 days',
    now() - interval '12 days',
    '2f046dd1-cd22-4fca-a9d4-624b48b61b6d',
    'jun.kim@example.com',
    '[]'::jsonb
);

--------------------------------------------------------------------------------
-- Ticket 8
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    'd7cfd54c-b15b-407c-af70-9771289ed6c2',
    'Refund not received',
    'I was promised a refund last week but haven''t seen it yet.',
    'open',
    'high',
    ARRAY['refund', 'billing'],
    '{"refund_amount": "49.99"}',
    '{
      "events": [
        {
          "id": "cae8b0f8-bc9d-4529-a0f3-83db1e259b78",
          "type": "message",
          "content": "My refund is overdue. Could you please check the status?",
          "created_at": "2025-01-08T14:10:00Z",
          "created_by_uuid": "afb2c4e2-0c9a-4b99-8fa7-ab84cbe77cb3",
          "created_by_first_name": "Helga",
          "created_by_last_name": "Schmidt",
          "visibility": "public",
          "attachments": []
        },
        {
          "id": "b44e33b6-8c48-4b66-96ee-b3fa54ef763b",
          "type": "assignment-added",
          "agent_id": "d24408aa-a333-4633-8a49-47d1ac3e24e2",
          "created_at": "2025-01-08T14:15:00Z",
          "created_by_uuid": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
          "created_by_first_name": "James",
          "created_by_last_name": "Martinez",
          "visibility": "public"
        },
        {
          "id": "cd11ec8c-4550-45e1-940a-fd3749778ab1",
          "type": "message",
          "content": "We''re confirming with accounting. Typically, refunds take 3-5 business days to appear.",
          "created_at": "2025-01-08T14:18:00Z",
          "created_by_uuid": "d24408aa-a333-4633-8a49-47d1ac3e24e2",
          "created_by_first_name": "Roberto",
          "created_by_last_name": "Silva",
          "visibility": "public",
          "attachments": []
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "37f4fe49-0b32-4f03-ad13-2db765b40118",
          "content": "Check if transaction ID was generated in our payment gateway logs.",
          "created_at": "2025-01-08T14:17:00Z",
          "created_by": "d24408aa-a333-4633-8a49-47d1ac3e24e2"
        }
      ]
    }'::jsonb,
    '{
      "rating": 5,
      "comment": "Sehr schnelle Hilfe, danke!",
      "submitted_at": "2025-01-08T14:12:00Z"
    }'::jsonb,
    'chat',
    now() - interval '9 days',
    now() - interval '9 days',
    'afb2c4e2-0c9a-4b99-8fa7-ab84cbe77cb3',
    'helga.schmidt@example.com',
    '[]'::jsonb
);

--------------------------------------------------------------------------------
-- Ticket 9
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    'c06d489f-f18a-45ad-8393-ff7bf9ee3b60',
    'Mobile app crash on startup',
    'The mobile app crashes immediately after the splash screen.',
    'new',
    'high',
    ARRAY['mobile', 'crash'],
    '{"device_os": "Android 12"}',
    '{
      "events": [
        {
          "id": "67e43f15-6c9b-4b44-b65f-956cef8ef895",
          "type": "message",
          "content": "App crashes on startup every time.",
          "created_at": "2025-01-04T08:35:00Z",
          "created_by_uuid": "7affd409-0087-4a44-9922-bf28027feea7",
          "created_by_first_name": "Lucia",
          "created_by_last_name": "Rodriguez",
          "visibility": "public",
          "attachments": []
        },
        {
          "id": "8a1072e7-2b5f-4d1b-a2c2-10e8200dcdfb",
          "type": "message",
          "content": "Could you confirm your device model? We suspect a GPU rendering bug on certain devices.",
          "created_at": "2025-01-04T08:37:00Z",
          "created_by_uuid": "7a1b5e4c-2d3f-6789-9012-1a2b3c4d5e6f",
          "created_by_first_name": "Alex",
          "created_by_last_name": "Chen",
          "visibility": "public",
          "attachments": []
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "9b54278a-c80c-4b84-93b6-a6d407bde53b",
          "content": "Possible rendering issue in custom splash screen library.",
          "created_at": "2025-01-04T08:38:00Z",
          "created_by": "7a1b5e4c-2d3f-6789-9012-1a2b3c4d5e6f"
        }
      ]
    }'::jsonb,
    '{
      "rating": 5,
      "comment": "Excelente soporte, gracias!",
      "submitted_at": "2025-01-04T08:40:00Z"
    }'::jsonb,
    'web',
    now() - interval '8 days',
    now() - interval '8 days',
    '7affd409-0087-4a44-9922-bf28027feea7',
    'lucia.rodriguez@example.com',
    '[]'::jsonb
);

--------------------------------------------------------------------------------
-- Ticket 10
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    'c06ac673-24f1-45ec-a71b-f2fa7aae2eaf',
    'Need training materials',
    'Looking for in-depth training materials for new hires.',
    'new',
    'medium',
    ARRAY['training', 'onboarding'],
    '{"department": "HR"}',
    '{
      "events": [
        {
          "id": "2d57b814-1a26-4960-91cd-4d072ac689e1",
          "type": "message",
          "content": "We need official training documents for new hires.",
          "created_at": "2025-01-06T10:00:00Z",
          "created_by_uuid": "733d23f0-5057-4737-8a70-656deee126be",
          "created_by_first_name": "Alice",
          "created_by_last_name": "Martin",
          "visibility": "public",
          "attachments": []
        },
        {
          "id": "2fad7a85-ab9f-45c1-9fe6-65124a3f3fd9",
          "type": "message",
          "content": "Hi Alice! We have a new hire training portal with PDFs and videos. I can send you the link.",
          "created_at": "2025-01-06T10:02:00Z",
          "created_by_uuid": "a729d2ef-55c5-42f7-a211-88bcd104ec37",
          "created_by_first_name": "Linda",
          "created_by_last_name": "Gonzalez",
          "visibility": "public",
          "attachments": []
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "nt-187",
          "content": "Potential need for video training links",
          "created_at": "2025-01-06T10:05:00Z",
          "created_by": "a729d2ef-55c5-42f7-a211-88bcd104ec37"
        },
        {
          "id": "1c75e7c8-2f15-41a6-8014-963769103590",
          "content": "Check if we can schedule a live training webinar for HR staff.",
          "created_at": "2025-01-06T10:07:00Z",
          "created_by": "a729d2ef-55c5-42f7-a211-88bcd104ec37"
        }
      ]
    }'::jsonb,
    '{"rating": 0, "comment": "", "submitted_at": null}'::jsonb,
    'web',
    now() - interval '6 days',
    now() - interval '6 days',
    '733d23f0-5057-4737-8a70-656deee126be',
    'alice.martin@example.com',
    '[]'::jsonb
);

--------------------------------------------------------------------------------
-- Ticket 11
--------------------------------------------------------------------------------
INSERT INTO public.tickets (
    id,
    title,
    description,
    status,
    priority,
    tags,
    custom_fields,
    ticket_history,
    internal_notes,
    feedback,
    source_channel,
    created_at,
    updated_at,
    created_by,
    customer_email,
    assigned_to
) VALUES (
    'bb4461ac-24f2-4983-84ad-8cd58fa93b22',
    'Security question about API tokens',
    'Need clarification on rotating API tokens for security compliance.',
    'open',
    'medium',
    ARRAY['security', 'api', 'tokens'],
    '{"rotation_interval": "90_days"}',
    '{
      "events": [
        {
          "id": "7f4b35e9-f53b-43d5-b2f2-620b35d4f057",
          "type": "message",
          "content": "What''s the best practice for rotating API tokens every 90 days?",
          "created_at": "2025-01-07T14:00:00Z",
          "created_by_uuid": "b0a16a7f-b48b-4254-a7d7-fc5f79e3c263",
          "created_by_first_name": "Mehmet",
          "created_by_last_name": "Ersoy",
          "visibility": "public",
          "attachments": []
        },
        {
          "id": "25b5d282-119a-459a-82e7-b0ccace3b5cb",
          "type": "assignment-added",
          "agent_id": "6138599f-f760-4fac-9b8d-7b9ee6ed3b75",
          "created_at": "2025-01-07T14:05:00Z",
          "created_by_uuid": "9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab",
          "created_by_first_name": "James",
          "created_by_last_name": "Martinez",
          "visibility": "public"
        },
        {
          "id": "56c57314-1aa1-4522-a63c-a1d691832d24",
          "type": "message",
          "content": "We recommend rolling tokens in a staggered approach, maintaining parallel tokens for 24 hours.",
          "created_at": "2025-01-07T14:10:00Z",
          "created_by_uuid": "6138599f-f760-4fac-9b8d-7b9ee6ed3b75",
          "created_by_first_name": "David",
          "created_by_last_name": "Hall",
          "visibility": "public",
          "attachments": []
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "8299c918-f627-4c76-8be6-508d4c10cd2b",
          "content": "Confirm that recommended security guidelines align with ISO standards.",
          "created_at": "2025-01-07T14:08:00Z",
          "created_by": "6138599f-f760-4fac-9b8d-7b9ee6ed3b75"
        }
      ]
    }'::jsonb,
    '{"rating": 0, "comment": "", "submitted_at": null}'::jsonb,
    'web',
    now() - interval '5 days',
    now() - interval '5 days',
    'b0a16a7f-b48b-4254-a7d7-fc5f79e3c263',
    'mehmet.ersoy@example.com',
    '[]'::jsonb
);
