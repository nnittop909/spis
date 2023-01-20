class StandingCommitteesPdf < Prawn::Document
  TABLE_WIDTHS = [246, 120, 120, 410]
  # HEADING_WIDTHS = [160,120,70,100, 100]
  def initialize(committees, sp_term, year, view_context)
    # super(margin: 20, page_size: "LEGAL", page_layout: :landscape)
    super(margin: 20, page_size: [612, 936], page_layout: :landscape)
    @committees = committees
    @sp_term = sp_term
    @year = year
    @title = "#{@sp_term.number_ordinal} Sangguniang Panlalawigan Standing Committees"
    @view_context = view_context
    heading
    display_committees_table
  end

  def heading
    text "PROVINCIAL LOCAL GOVERNMENT UNIT - IFUGAO", align: :right, size: 8
    stroke_horizontal_rule
    move_down 5
    text @title.upcase, align: :center, size: 14, style: :bold
    move_down 2
    text @sp_term.in_year_range, align: :center, size: 11, style: :bold
    stroke_horizontal_rule
  end

  def display_committees_table
    if @committees.blank?
      move_down 10
      text "No data.", align: :center
    else
      move_down 4
      header = [["COMMITTEE", "CHAIRPERSON", "VICE CHAIRPERSON", "MEMBERS"]]
      table(header, :cell_style => {size: 9, :padding => [2, 4, 2, 4]}, column_widths: TABLE_WIDTHS) do
        cells.borders = [:top, :right, :bottom, :left]
        row(0).font_style = :bold
        column(3).align = :center
      end
      stroke_horizontal_rule
      committees_data = @committees.map { |c| [c.name.titleize, c.by_term_chairperson(@year).try(:name_in_honorifics).try(:titleize), c.by_term_vice_chairperson(@year).try(:name_in_honorifics).try(:titleize), c.by_term_members(@year).map{|m| m.name_in_honorifics.try(:titleize)}.join(", ")]}
      table_data = [*committees_data]
      table(table_data, cell_style: { size: 9, font: "Helvetica", inline_format: true, :padding => [2, 4, 2, 4]}, column_widths: TABLE_WIDTHS) do
        cells.borders = [:top, :right, :bottom, :left]
      end
    end
  end
end