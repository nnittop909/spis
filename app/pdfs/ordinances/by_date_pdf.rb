module Ordinances
  class ByDatePdf < Prawn::Document
    TABLE_WIDTHS = [100, 472]
    HEADING_WIDTHS = [150,120,70,100, 100]
    def initialize(ordinances, category, from_date, to_date, view_context)
      super(margin: 20, page_size: [612, 936], page_layout: :portrait)
      @ordinances = ordinances
      @category = category
      @from_date = from_date.present? ? from_date.to_date : oldest_date
      @to_date = to_date.present? ? to_date.to_date : Date.today
      @view_context = view_context
      heading
      display_ordinances_table
    end

    def heading
      text title, align: :center, size: 13, style: :bold
      move_down 2
      text dates_in_range, align: :center, size: 11, style: :bold
    end

    def display_ordinances_table
      if @ordinances.blank?
        move_down 10
        text "No data.", align: :center
      else
        move_down 4
        header = [["ORDINANCE #", "TITLE"]]
        table(header, :cell_style => {size: 9, :padding => [2, 4, 2, 4]}, column_widths: TABLE_WIDTHS) do
          cells.borders = [:top, :right, :bottom, :left]
          row(0).font_style = :bold
          column(1).align = :center
        end
        stroke_horizontal_rule
        header = ["", ""]
        ordinances_data = @ordinances.map { |o| ["#{o.number}\nApproved: #{o.date_approved}", o.title]}
        table_data = [header, *ordinances_data]
        table(table_data, cell_style: { size: 9, font: "Helvetica", inline_format: true, :padding => [2, 4, 2, 4]}, column_widths: TABLE_WIDTHS) do
          cells.borders = [:top, :right, :bottom, :left]
          row(0).font_style = :bold
          column(1).align = :justify
        end
      end
    end

    def dates_in_range
      if @from_date < 15.years.ago
        "As of #{@to_date.strftime("%B %e, %Y")}"
      else
        "#{@from_date.strftime("%B %e, %Y")} - #{@to_date.strftime("%B %e, %Y")}"
      end
    end

    def oldest_date
      Staging.where(stageable_type: "Ordinance").order(:date).first.date
    end

    def title
      if @category.present?
        if @category.name == "General"
          "Ordinances"
        else
          "#{@category.name} Ordinances"
        end
      else
        "Ordinances"
      end
    end
  end
end