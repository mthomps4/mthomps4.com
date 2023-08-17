module ThemeHelper
  def button_classes(_classes, **_args)
    class_variants('inline-flex items-center rounded border border-transparent font-medium text-white hover:text-white shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2',
                   variants: {
                     size: {
                       sm: 'px-2.5 py-1.5 text-xs',
                       md: 'px-3 py-2 text-sm',
                       lg: 'px-4 py-2 text-sm',
                       xl: 'px-4 py-2 text-base'
                     },
                     color: {
                       indigo: 'bg-indigo-600 hover:bg-indigo-700 focus:ring-indigo-500',
                       red: 'bg-red-600 hover:bg-red-700 focus:ring-red-500',
                       blue: 'bg-blue-600 hover:bg-blue-700 focus:ring-blue-500'
                     }
                   },
                   defaults: {
                     size: :md,
                     color: :indigo
                   })
  end

  # def b_classes
  #   ClassVariants.build(
  #     'inline-flex items-center rounded border border-transparent font-medium text-white hover:text-white shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2',
  #     variants: {
  #       size: {
  #         sm: 'px-2.5 py-1.5 text-xs',
  #         md: 'px-3 py-2 text-sm',
  #         lg: 'px-4 py-2 text-sm',
  #         xl: 'px-4 py-2 text-base'
  #       },
  #       color: {
  #         indigo: 'bg-indigo-600 hover:bg-indigo-700 focus:ring-indigo-500',
  #         red: 'bg-red-600 hover:bg-red-700 focus:ring-red-500',
  #         blue: 'bg-blue-600 hover:bg-blue-700 focus:ring-blue-500'
  #       },
  #       # A variant whose value is a string will be expanded into a hash that looks
  #       # like  { true => "classes" }
  #       block: 'w-full justify-center',
  #       # Unless the key starts with !, in which case it will expand into
  #       # { false => "classes" }
  #       "!block": 'w-auto'
  #     },
  #     defaults: {
  #       size: :md,
  #       color: :indigo,
  #       icon: false
  #     }
  #   )
  # end
end
