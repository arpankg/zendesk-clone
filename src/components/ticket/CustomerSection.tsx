import { type Customer } from '../../../config/types'

interface CustomerSectionProps {
  customer: Customer
  isExpanded?: boolean
}

export function CustomerSection({ customer, isExpanded = true }: CustomerSectionProps) {
  return (
    <div className="border-b border-gray-200 pb-4">
      <div className="flex items-center justify-between mb-2">
        <h3 className="text-sm font-medium text-gray-900">Customer</h3>
        <button className="p-1 text-gray-400 hover:text-gray-600">
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
          </svg>
        </button>
      </div>
      
      {isExpanded && (
        <div className="space-y-4">
          <div>
            <div className="flex items-center justify-between">
              <div className="flex items-center space-x-2">
                <div className="text-sm font-medium text-gray-900">
                  {customer.first_name} {customer.last_name}
                </div>
              </div>
              <button className="text-sm text-blue-600 hover:text-blue-700">
                Edit
              </button>
            </div>
            <div className="mt-1 text-sm text-gray-500">{customer.email}</div>
          </div>

          <div>
            <div className="text-sm text-gray-500">Language</div>
            <div className="mt-1 text-sm text-gray-900">{customer.preferred_language || 'Not set'}</div>
          </div>

          <div>
            <div className="text-sm text-gray-500">Communication Channels</div>
            <div className="mt-1 flex flex-wrap gap-2">
              {customer.communication_channels?.map((channel: string) => (
                <span
                  key={channel}
                  className="inline-flex items-center rounded-full bg-blue-50 px-2 py-1 text-xs font-medium text-blue-700"
                >
                  {channel}
                </span>
              )) || 'None set'}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
