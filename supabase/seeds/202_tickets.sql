-- FILE: 50_new_tickets.sql
-- Inserts 5 new tickets with the required specifications:
--  * Each has 10+ events in ticket_history
--  * Each has at least 5 agent/customer messages
--  * At least 4 internal notes each
--  * Feedback only on closed tickets
--  * Valid references to existing customers and workers from seed data

--------------------------------------------------------------------------------
-- TICKET 1 (OPEN) - Created by Fatima Ali, assigned to Neeraj Gupta
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
)
VALUES (
    '6b9da39c-0790-465f-bb9d-759182053011',
    'Critical error after login',
    'Upon logging in, I encounter a 500 error page preventing me from accessing my account.',
    'open',
    'high',
    ARRAY['login','error','critical','urgent'],
    '{"app_version":"v2.3.0","environment":"production"}',
    '{
      "events": [
        {
          "id": "01cbdcf6-6712-4cf1-8498-c6286ce2e501",
          "type": "message",
          "content": "Whenever I log in, I get a 500 error on the dashboard.",
          "created_at": "2025-01-20T10:00:00Z",
          "created_by_uuid": "c9dd1b9c-cd53-4f02-a88c-7252c6451f36",
          "created_by_first_name": "Fatima",
          "created_by_last_name": "Ali",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "b27f9eb5-9d0c-4034-b1b2-8e1f9af3766a",
          "type": "status-update",
          "old_value": "new",
          "new_value": "open",
          "created_at": "2025-01-20T10:01:00Z",
          "created_by_uuid": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b",
          "created_by_first_name": "Neeraj",
          "created_by_last_name": "Gupta",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "95143ee7-feb9-43ed-bffe-933f75c43b19",
          "type": "assignment-added",
          "agent_id": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b",
          "created_at": "2025-01-20T10:02:00Z",
          "created_by_uuid": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b",
          "created_by_first_name": "Neeraj",
          "created_by_last_name": "Gupta",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "581fbaf0-5c1f-4ab6-9aae-86cf14180e31",
          "type": "message",
          "content": "Hello Fatima, this is Neeraj. Sorry about the error. We''re looking into server logs now. Can you confirm if you tried clearing cache?",
          "created_at": "2025-01-20T10:03:00Z",
          "created_by_uuid": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b",
          "created_by_first_name": "Neeraj",
          "created_by_last_name": "Gupta",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "e87ebdc5-c7e8-44a1-b592-b94c75773dfb",
          "type": "message",
          "content": "Yes, I tried clearing cache and cookies. No change.",
          "created_at": "2025-01-20T10:05:00Z",
          "created_by_uuid": "c9dd1b9c-cd53-4f02-a88c-7252c6451f36",
          "created_by_first_name": "Fatima",
          "created_by_last_name": "Ali",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "5eb9bc62-f638-44bd-9950-8f64447e91bb",
          "type": "message",
          "content": "Understood. Checking if a new release went out. Which browser are you using?",
          "created_at": "2025-01-20T10:07:00Z",
          "created_by_uuid": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b",
          "created_by_first_name": "Neeraj",
          "created_by_last_name": "Gupta",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "c473461a-49d2-4c83-8f88-a5c5dc6b00fe",
          "type": "message",
          "content": "Tested on both Chrome and Firefox. Same 500 error on both.",
          "created_at": "2025-01-20T10:09:00Z",
          "created_by_uuid": "c9dd1b9c-cd53-4f02-a88c-7252c6451f36",
          "created_by_first_name": "Fatima",
          "created_by_last_name": "Ali",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "22fd2f57-d889-4d9a-93c0-a2938cfc499d",
          "type": "message",
          "content": "Thanks for confirming. I see an error referencing a missing module. We''re restarting the service. Please try again in a minute.",
          "created_at": "2025-01-20T10:11:00Z",
          "created_by_uuid": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b",
          "created_by_first_name": "Neeraj",
          "created_by_last_name": "Gupta",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "86e7260d-7e45-44f3-974a-58aa6d06f0a0",
          "type": "message",
          "content": "I retried. Still 500. Might be a deployment issue?",
          "created_at": "2025-01-20T10:13:00Z",
          "created_by_uuid": "c9dd1b9c-cd53-4f02-a88c-7252c6451f36",
          "created_by_first_name": "Fatima",
          "created_by_last_name": "Ali",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "e7818f93-ef89-4b95-9b20-7b84577b12b2",
          "type": "message",
          "content": "Let me revert the last deployment. Thanks for your patience.",
          "created_at": "2025-01-20T10:15:00Z",
          "created_by_uuid": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b",
          "created_by_first_name": "Neeraj",
          "created_by_last_name": "Gupta",
          "role": "agent",
          "visibility": "public"
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "915a8549-3f13-46bb-8a29-9bcdfb5b3d7b",
          "content": "Suspect server-side error, possibly code deployment failure.",
          "created_at": "2025-01-20T10:20:00Z",
          "created_by": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b"
        },
        {
          "id": "c40a7eed-8769-4a2d-bfd3-c517a272a8fe",
          "content": "DevOps team investigating logs. Escalated to L2 support.",
          "created_at": "2025-01-20T10:21:00Z",
          "created_by": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b"
        },
        {
          "id": "3df0a1ab-538a-45eb-8fbf-cb7070d84e1b",
          "content": "Possible DB migration mismatch if environment variables changed.",
          "created_at": "2025-01-20T10:22:00Z",
          "created_by": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b"
        },
        {
          "id": "c67dfbbc-32b6-49c1-9139-ba79f1a5bf05",
          "content": "Customer has tried multiple browsers, issue persists.",
          "created_at": "2025-01-20T10:23:00Z",
          "created_by": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b"
        }
      ]
    }'::jsonb,
    '{"rating":0, "comment":"", "submitted_at": null}'::jsonb,
    'web',
    now(),
    now(),
    'c9dd1b9c-cd53-4f02-a88c-7252c6451f36',
    'fatima.ali@example.com',
    '[
      {
        "id": "bf446b73-41c7-48aa-a8c0-2ee4d3f7605b",
        "first_name": "Neeraj",
        "last_name": "Gupta"
      }
    ]'::jsonb
);

--------------------------------------------------------------------------------
-- TICKET 2 (CLOSED) - Created by Sarah Miller, assigned to Zac Smith, includes feedback
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
)
VALUES (
    'af422e2c-740c-4e3c-b29d-2d9271b5dbaa',
    'Account upgrade not reflecting',
    'I upgraded my account to Premium, but the features are still locked.',
    'closed',
    'medium',
    ARRAY['upgrade','billing','premium'],
    '{"plan_type":"premium","billing_cycle":"monthly"}',
    '{
      "events": [
        {
          "id": "939517aa-71d8-4f8e-9d4a-95dfa1f78955",
          "type": "message",
          "content": "Hello, I upgraded but can''t see premium features.",
          "created_at": "2025-01-15T09:00:00Z",
          "created_by_uuid": "f23c5c88-2322-4c2d-9f59-43e79a9b5c44",
          "created_by_first_name": "Sarah",
          "created_by_last_name": "Miller",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "acc6ec07-9ec8-4d19-9c23-1aa47e39a5fd",
          "type": "status-update",
          "old_value": "new",
          "new_value": "open",
          "created_at": "2025-01-15T09:01:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "db43005f-153c-44b2-80b0-6ab69d4fbe3b",
          "type": "assignment-added",
          "agent_id": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_at": "2025-01-15T09:02:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "bd053e6f-18df-4a38-aeb0-284df05cd3a7",
          "type": "message",
          "content": "Hi Sarah, I see your payment was processed. Let me manually refresh your account flags.",
          "created_at": "2025-01-15T09:03:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "7f105090-a697-4cf2-a525-e2d0373dc900",
          "type": "message",
          "content": "Okay, logging out and back in... still not working.",
          "created_at": "2025-01-15T09:05:00Z",
          "created_by_uuid": "f23c5c88-2322-4c2d-9f59-43e79a9b5c44",
          "created_by_first_name": "Sarah",
          "created_by_last_name": "Miller",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "2f655ff9-7129-4bfa-928b-d625a7b592cb",
          "type": "message",
          "content": "Strange, let me flush the cache on our end. Could you also clear your browser storage?",
          "created_at": "2025-01-15T09:06:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "104652a6-f7f6-4669-8789-4af44de86a27",
          "type": "message",
          "content": "Tried that, still no luck. Let me try on a different device.",
          "created_at": "2025-01-15T09:08:00Z",
          "created_by_uuid": "f23c5c88-2322-4c2d-9f59-43e79a9b5c44",
          "created_by_first_name": "Sarah",
          "created_by_last_name": "Miller",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "4e0f9fcf-fa9e-4759-877c-509c59e72e3f",
          "type": "message",
          "content": "Let me update your subscription status in the DB. Try again now.",
          "created_at": "2025-01-15T09:10:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "cefc5ff7-5592-4f77-80c8-845540bd0b4f",
          "type": "message",
          "content": "Now it shows Premium! Thank you for the help.",
          "created_at": "2025-01-15T09:12:00Z",
          "created_by_uuid": "f23c5c88-2322-4c2d-9f59-43e79a9b5c44",
          "created_by_first_name": "Sarah",
          "created_by_last_name": "Miller",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "0784c7d9-7cf9-44d4-a2aa-c9ec165bfcbf",
          "type": "status-update",
          "old_value": "open",
          "new_value": "closed",
          "created_at": "2025-01-15T09:14:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "f1f273bc-5ced-40aa-9467-b8369ad87065",
          "content": "Customer paid, but subscription flag not updated. Possibly a billing API lag.",
          "created_at": "2025-01-15T09:02:00Z",
          "created_by": "f61f3731-b70e-4fa8-af5c-17be2fba141c"
        },
        {
          "id": "0a5c827f-466c-4815-99c4-bd6dcf13545c",
          "content": "Had to manually set DB field to reflect premium features.",
          "created_at": "2025-01-15T09:11:00Z",
          "created_by": "f61f3731-b70e-4fa8-af5c-17be2fba141c"
        },
        {
          "id": "7a5bb868-d19e-4bd0-a739-e5a889cdfe49",
          "content": "Recommend investigating possible bug in payment callback flow.",
          "created_at": "2025-01-15T09:12:00Z",
          "created_by": "f61f3731-b70e-4fa8-af5c-17be2fba141c"
        },
        {
          "id": "58426089-1d66-4952-931d-1d975f3d0e1a",
          "content": "Customer is satisfied, closed ticket after verifying premium features.",
          "created_at": "2025-01-15T09:14:30Z",
          "created_by": "f61f3731-b70e-4fa8-af5c-17be2fba141c"
        }
      ]
    }'::jsonb,
    '{
      "rating":4,
      "comment":"Quick resolution once we did a manual fix",
      "submitted_at":"2025-01-15T09:15:00Z"
    }'::jsonb,
    'web',
    now(),
    now(),
    'f23c5c88-2322-4c2d-9f59-43e79a9b5c44',
    'sarah.miller@example.com',
    '[
      {
        "id": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
        "first_name": "Zac",
        "last_name": "Smith"
      }
    ]'::jsonb
);

--------------------------------------------------------------------------------
-- TICKET 3 (OPEN) - Created by Aarav Patel, assigned to Austen Allred
-- No feedback because status != closed
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
)
VALUES (
    '2b9ad596-5df5-4d8f-8655-b7f60b3803ea',
    'Recurring double charge',
    'I have been charged twice for the same billing cycle two months in a row.',
    'open',
    'high',
    ARRAY['billing','duplicate','charge'],
    '{"billing_issue":"double-charge"}',
    '{
      "events": [
        {
          "id": "d3fbbcae-57b9-4de2-af02-86463a5bbbe6",
          "type": "message",
          "content": "I''m seeing two charges on my credit card statement for this month.",
          "created_at": "2025-01-18T08:00:00Z",
          "created_by_uuid": "6f46bb43-1913-4bd0-8489-3f8c8575f633",
          "created_by_first_name": "Aarav",
          "created_by_last_name": "Patel",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "36d98091-3ac2-401f-b364-5695550afe41",
          "type": "status-update",
          "old_value": "new",
          "new_value": "open",
          "created_at": "2025-01-18T08:01:00Z",
          "created_by_uuid": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8",
          "created_by_first_name": "Austen",
          "created_by_last_name": "Allred",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "96222f0a-6c2d-4c08-a99b-3443a707d941",
          "type": "assignment-added",
          "agent_id": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8",
          "created_at": "2025-01-18T08:02:00Z",
          "created_by_uuid": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8",
          "created_by_first_name": "Austen",
          "created_by_last_name": "Allred",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "b89ff192-3e3a-4783-9099-51056b4027b0",
          "type": "message",
          "content": "Hi Aarav, I''ll check our billing system logs. Could you confirm the last four digits of the card used?",
          "created_at": "2025-01-18T08:03:00Z",
          "created_by_uuid": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8",
          "created_by_first_name": "Austen",
          "created_by_last_name": "Allred",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "91165cde-27e3-4d04-982b-326c8af85da2",
          "type": "message",
          "content": "Sure, last four are 1234. This happened last month too.",
          "created_at": "2025-01-18T08:05:00Z",
          "created_by_uuid": "6f46bb43-1913-4bd0-8489-3f8c8575f633",
          "created_by_first_name": "Aarav",
          "created_by_last_name": "Patel",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "165e2313-c4f6-432a-aeba-c64357cc65aa",
          "type": "message",
          "content": "Let me see if a second subscription was accidentally created. Checking the database now.",
          "created_at": "2025-01-18T08:07:00Z",
          "created_by_uuid": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8",
          "created_by_first_name": "Austen",
          "created_by_last_name": "Allred",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "848b2f4b-6b0e-4c0d-9e4f-b9b914eb616f",
          "type": "message",
          "content": "Any updates? Another payment just posted this morning.",
          "created_at": "2025-01-18T08:10:00Z",
          "created_by_uuid": "6f46bb43-1913-4bd0-8489-3f8c8575f633",
          "created_by_first_name": "Aarav",
          "created_by_last_name": "Patel",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "5f3f4132-cfa3-4cc2-b141-7b754c5a9db6",
          "type": "field-added",
          "field_name": "duplicate_subscription_id",
          "new_value": "temp-abc123",
          "created_at": "2025-01-18T08:11:00Z",
          "created_by_uuid": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8",
          "created_by_first_name": "Austen",
          "created_by_last_name": "Allred",
          "role": "agent",
          "visibility": "private"
        },
        {
          "id": "b29f371d-774a-4757-8cc0-a0414d6d80a8",
          "type": "message",
          "content": "I found a duplicate subscription entry. I''ve canceled it and requested a refund for last two charges.",
          "created_at": "2025-01-18T08:12:00Z",
          "created_by_uuid": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8",
          "created_by_first_name": "Austen",
          "created_by_last_name": "Allred",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "08aa6e5a-1a33-4cc4-8aaa-01b01cd8d6b3",
          "type": "message",
          "content": "Perfect, thanks. Let me know if you need anything else from my side.",
          "created_at": "2025-01-18T08:14:00Z",
          "created_by_uuid": "6f46bb43-1913-4bd0-8489-3f8c8575f633",
          "created_by_first_name": "Aarav",
          "created_by_last_name": "Patel",
          "role": "customer",
          "visibility": "public"
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "d2d5d203-efed-4413-9f24-76d7c4beab1b",
          "content": "Duplicate subscription found in billing records, presumably a glitch.",
          "created_at": "2025-01-18T08:06:00Z",
          "created_by": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8"
        },
        {
          "id": "80856406-3626-4c40-bb4e-90297ee3beab",
          "content": "Refund request submitted. Customer should see credit in 3-5 business days.",
          "created_at": "2025-01-18T08:13:00Z",
          "created_by": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8"
        },
        {
          "id": "c3ecba37-bb9c-4ae7-b97c-a099e17c0990",
          "content": "Will monitor to ensure no further duplicate charges appear next cycle.",
          "created_at": "2025-01-18T08:15:00Z",
          "created_by": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8"
        },
        {
          "id": "880a99e6-1ef4-4d12-a4bd-3dfde42eb51f",
          "content": "Customer remains calm, not escalated. Keeping open until refund is confirmed.",
          "created_at": "2025-01-18T08:16:00Z",
          "created_by": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8"
        }
      ]
    }'::jsonb,
    '{"rating":0,"comment":"","submitted_at":null}'::jsonb,
    'email',
    now(),
    now(),
    '6f46bb43-1913-4bd0-8489-3f8c8575f633',
    'aarav.patel@example.com',
    '[
      {
        "id": "b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8",
        "first_name": "Austen",
        "last_name": "Allred"
      }
    ]'::jsonb
);

--------------------------------------------------------------------------------
-- TICKET 4 (OPEN) - Created by Lucia Rodriguez, assigned to Ash Tilawat
-- No feedback because status != closed
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
)
VALUES (
    'f58e08f8-3b8c-49f7-b850-f8521c01c505',
    'Unable to reset password',
    'Clicking the Reset Password link sends no email. I''ve tried multiple times.',
    'open',
    'medium',
    ARRAY['password','reset','email','no-delivery'],
    '{"communication_issue":"email not sent"}',
    '{
      "events": [
        {
          "id": "0b327364-0901-4fb3-a29f-9cc291a0bcdc",
          "type": "message",
          "content": "I can''t reset my password. The link says email sent, but I got nothing.",
          "created_at": "2025-01-19T14:00:00Z",
          "created_by_uuid": "7affd409-0087-4a44-9922-bf28027feea7",
          "created_by_first_name": "Lucia",
          "created_by_last_name": "Rodriguez",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "99daf881-1965-46fd-b4d6-8b50d6dc7de5",
          "type": "status-update",
          "old_value": "new",
          "new_value": "open",
          "created_at": "2025-01-19T14:01:00Z",
          "created_by_uuid": "d89637a2-1f11-4027-86db-e7d47a579ae1",
          "created_by_first_name": "Ash",
          "created_by_last_name": "Tilawat",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "42467ee0-3b05-45d2-be18-3c7316bd78ab",
          "type": "assignment-added",
          "agent_id": "d89637a2-1f11-4027-86db-e7d47a579ae1",
          "created_at": "2025-01-19T14:02:00Z",
          "created_by_uuid": "d89637a2-1f11-4027-86db-e7d47a579ae1",
          "created_by_first_name": "Ash",
          "created_by_last_name": "Tilawat",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "01dbbb57-8476-4d75-b73d-94d31d8e5ee2",
          "type": "message",
          "content": "Hi Lucia, we sometimes see spam filters catch these emails. Could you check spam and promotions folders?",
          "created_at": "2025-01-19T14:03:00Z",
          "created_by_uuid": "d89637a2-1f11-4027-86db-e7d47a579ae1",
          "created_by_first_name": "Ash",
          "created_by_last_name": "Tilawat",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "fe036ed5-2ab6-463c-9c77-c73453a03333",
          "type": "message",
          "content": "Yes, checked spam. Not there. Also tested with my secondary email, still no link.",
          "created_at": "2025-01-19T14:05:00Z",
          "created_by_uuid": "7affd409-0087-4a44-9922-bf28027feea7",
          "created_by_first_name": "Lucia",
          "created_by_last_name": "Rodriguez",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "0951c160-bb84-4a11-88d2-be10b18f341a",
          "type": "message",
          "content": "Understood. Let me manually trigger a password reset email from our admin console.",
          "created_at": "2025-01-19T14:06:00Z",
          "created_by_uuid": "d89637a2-1f11-4027-86db-e7d47a579ae1",
          "created_by_first_name": "Ash",
          "created_by_last_name": "Tilawat",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "aae44904-5425-4db3-a9b4-3a5e0b60883f",
          "type": "message",
          "content": "Still nothing. Could there be a problem with the email service on your end?",
          "created_at": "2025-01-19T14:08:00Z",
          "created_by_uuid": "7affd409-0087-4a44-9922-bf28027feea7",
          "created_by_first_name": "Lucia",
          "created_by_last_name": "Rodriguez",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "c6f504a7-f965-4bec-9183-089c243a783a",
          "type": "field-added",
          "field_name": "email_service_debug",
          "new_value": "Manual send triggered",
          "created_at": "2025-01-19T14:09:00Z",
          "created_by_uuid": "d89637a2-1f11-4027-86db-e7d47a579ae1",
          "created_by_first_name": "Ash",
          "created_by_last_name": "Tilawat",
          "role": "agent",
          "visibility": "private"
        },
        {
          "id": "c0ecc232-d6ec-4bca-9092-bf0982061ed9",
          "type": "message",
          "content": "We''re investigating mail logs. I see no bounce or spam event. Might be an SMTP config issue. Apologies for the hassle.",
          "created_at": "2025-01-19T14:10:00Z",
          "created_by_uuid": "d89637a2-1f11-4027-86db-e7d47a579ae1",
          "created_by_first_name": "Ash",
          "created_by_last_name": "Tilawat",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "9e711442-4c01-4b76-9153-d621ef111c31",
          "type": "message",
          "content": "Alright, I''ll wait for an update. Thanks.",
          "created_at": "2025-01-19T14:12:00Z",
          "created_by_uuid": "7affd409-0087-4a44-9922-bf28027feea7",
          "created_by_first_name": "Lucia",
          "created_by_last_name": "Rodriguez",
          "role": "customer",
          "visibility": "public"
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "84b87f06-938b-4dbc-b3e1-238a0738da8f",
          "content": "Possibility of domain-level blocking or SPF misconfiguration.",
          "created_at": "2025-01-19T14:07:00Z",
          "created_by": "d89637a2-1f11-4027-86db-e7d47a579ae1"
        },
        {
          "id": "edd03039-e120-496d-9b10-6612d9787e53",
          "content": "Checking AWS SES logs for unusual rejects or throttling.",
          "created_at": "2025-01-19T14:09:30Z",
          "created_by": "d89637a2-1f11-4027-86db-e7d47a579ae1"
        },
        {
          "id": "277a256a-d457-480c-9ef3-c96976540bea",
          "content": "So far no bounce or complaint logs for Lucia''s addresses.",
          "created_at": "2025-01-19T14:11:00Z",
          "created_by": "d89637a2-1f11-4027-86db-e7d47a579ae1"
        },
        {
          "id": "6e14df14-e63e-4a26-bb02-cda9db6a66e3",
          "content": "Might need to escalate to DevOps if we confirm SMTP config is correct.",
          "created_at": "2025-01-19T14:12:30Z",
          "created_by": "d89637a2-1f11-4027-86db-e7d47a579ae1"
        }
      ]
    }'::jsonb,
    '{"rating":0,"comment":"","submitted_at":null}'::jsonb,
    'chat',
    now(),
    now(),
    '7affd409-0087-4a44-9922-bf28027feea7',
    'lucia.rodriguez@example.com',
    '[
      {
        "id": "d89637a2-1f11-4027-86db-e7d47a579ae1",
        "first_name": "Ash",
        "last_name": "Tilawat"
      }
    ]'::jsonb
);

--------------------------------------------------------------------------------
-- TICKET 5 (CLOSED) - Created by John Doe, assigned to Zac Smith, includes feedback
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
)
VALUES (
    '5e24cfd7-299f-4d02-9c8a-41c232bda3ea',
    'API rate limit confusion',
    'I am receiving 429 Too Many Requests, but usage is well below the stated limit.',
    'closed',
    'medium',
    ARRAY['api','rate-limit','throttling'],
    '{"api_tier":"basic"}',
    '{
      "events": [
        {
          "id": "23a1d8d0-9a9d-443e-9da2-2f5568e0d470",
          "type": "message",
          "content": "I keep getting 429 errors even though I''m within limit.",
          "created_at": "2025-01-17T07:00:00Z",
          "created_by_uuid": "a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f",
          "created_by_first_name": "John",
          "created_by_last_name": "Doe",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "46a818d1-5f94-4c48-8dcf-34464c07f9c7",
          "type": "status-update",
          "old_value": "new",
          "new_value": "open",
          "created_at": "2025-01-17T07:01:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "d5dd9513-b39b-4177-ba59-065ff347fe46",
          "type": "assignment-added",
          "agent_id": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_at": "2025-01-17T07:02:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "6442e18f-d203-4375-a52e-297b5f6cf53a",
          "type": "message",
          "content": "Hello John, I see your logs. The system shows a burst of calls that triggered the limit. Could you confirm your concurrency approach?",
          "created_at": "2025-01-17T07:03:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "a99fc5d7-3a8e-4cb6-b704-7200e5f01463",
          "type": "message",
          "content": "We''re sending about 10 requests per second max. The doc says we can do up to 20/sec on Basic tier.",
          "created_at": "2025-01-17T07:05:00Z",
          "created_by_uuid": "a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f",
          "created_by_first_name": "John",
          "created_by_last_name": "Doe",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "7c720e91-3e92-4b13-9f5c-43667cfa001f",
          "type": "message",
          "content": "We have a known bug in rate-limiter where short bursts sometimes trip the threshold. Patch is pending. For now, add a 1-second retry delay.",
          "created_at": "2025-01-17T07:07:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "8f065835-c5b5-4f3b-a647-54aff2e6a753",
          "type": "message",
          "content": "Okay, I''ll do that. Thanks for letting me know. When do you expect the patch?",
          "created_at": "2025-01-17T07:10:00Z",
          "created_by_uuid": "a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f",
          "created_by_first_name": "John",
          "created_by_last_name": "Doe",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "a6c757f7-2427-4923-a4b0-750dd3a018b2",
          "type": "message",
          "content": "Likely next week. Sorry for the inconvenience. Let us know if the delay helps in the meantime.",
          "created_at": "2025-01-17T07:12:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        },
        {
          "id": "814cc909-4835-4edc-9ed2-54093cc35281",
          "type": "message",
          "content": "That workaround is fine. Thanks for the support!",
          "created_at": "2025-01-17T07:14:00Z",
          "created_by_uuid": "a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f",
          "created_by_first_name": "John",
          "created_by_last_name": "Doe",
          "role": "customer",
          "visibility": "public"
        },
        {
          "id": "a2990efd-62ec-4cd8-9c1b-509f24dfe864",
          "type": "status-update",
          "old_value": "open",
          "new_value": "closed",
          "created_at": "2025-01-17T07:15:00Z",
          "created_by_uuid": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
          "created_by_first_name": "Zac",
          "created_by_last_name": "Smith",
          "role": "agent",
          "visibility": "public"
        }
      ]
    }'::jsonb,
    '{
      "notes": [
        {
          "id": "e6c88f6f-603d-41b2-9ab9-b9387075c64a",
          "content": "Rate limiter known bug. Temporary fix: add short delay to calls.",
          "created_at": "2025-01-17T07:02:30Z",
          "created_by": "f61f3731-b70e-4fa8-af5c-17be2fba141c"
        },
        {
          "id": "dcd0d77b-a027-4fca-9df6-5a975c658ac3",
          "content": "Patch scheduled for next release, likely next week.",
          "created_at": "2025-01-17T07:08:00Z",
          "created_by": "f61f3731-b70e-4fa8-af5c-17be2fba141c"
        },
        {
          "id": "0a1d8883-a605-4e3a-8658-6131364e2d41",
          "content": "Confirmed that concurrency can spike momentarily, causing 429.",
          "created_at": "2025-01-17T07:11:00Z",
          "created_by": "f61f3731-b70e-4fa8-af5c-17be2fba141c"
        },
        {
          "id": "7437492d-c584-46cd-8ce8-89ebf866e792",
          "content": "Closed after confirming workaround with the user.",
          "created_at": "2025-01-17T07:16:00Z",
          "created_by": "f61f3731-b70e-4fa8-af5c-17be2fba141c"
        }
      ]
    }'::jsonb,
    '{
      "rating":5,
      "comment":"Great support, identified the root cause quickly.",
      "submitted_at":"2025-01-17T07:20:00Z"
    }'::jsonb,
    'web',
    now(),
    now(),
    'a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f',
    'john.doe@example.com',
    '[
      {
        "id": "f61f3731-b70e-4fa8-af5c-17be2fba141c",
        "first_name": "Zac",
        "last_name": "Smith"
      }
    ]'::jsonb
);
