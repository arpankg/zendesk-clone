import { type TicketStatus, type TicketPriority } from '@/config/types'

interface PropertiesSectionProps {
  sourceChannel: string
  tags: string[]
  isExpanded?: boolean
}

export function PropertiesSection({
  sourceChannel,
  tags,
  isExpanded = true
}: PropertiesSectionProps) {
  return (
    <div className="border-b border-gray-200 pb-4">
      <div className="flex items-center justify-between mb-2">
        <h3 className="text-sm font-medium text-gray-900">Properties</h3>
        <button className="p-1 text-gray-400 hover:text-gray-600">
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
          </svg>
        </button>
      </div>

      {isExpanded && (
        <div className="space-y-4">
          {/* Tags Section */}
          <div>
            <div className="flex items-center justify-between">
              <div className="text-sm text-gray-500">Tags</div>
              <button className="text-sm text-blue-600 hover:text-blue-700">
                Add
              </button>
            </div>
            <div className="mt-2 flex flex-wrap gap-2">
              {tags.map((tag) => (
                <span
                  key={tag}
                  className="inline-flex items-center gap-1 rounded-full bg-gray-50 px-2 py-1 text-xs font-medium text-gray-600"
                >
                  {tag}
                  <button
                    type="button"
                    className="text-gray-400 hover:text-gray-600"
                  >
                    <svg className="h-3 w-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                    </svg>
                  </button>
                </span>
              ))}
              {tags.length === 0 && (
                <span className="text-sm text-gray-500">No tags</span>
              )}
            </div>
          </div>

          {/* Source Section */}
          <div>
            <div className="text-sm text-gray-500">Source</div>
            <div className="mt-1 text-sm text-gray-900">{sourceChannel}</div>
          </div>
        </div>
      )}
    </div>
  )
}
