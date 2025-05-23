import json
import os
from deepdiff import DeepDiff

def get_valid_path(filename):
    """Search for file in common directories"""
    search_paths = [
        os.path.join(os.getcwd(), filename),
        os.path.join(os.getcwd(), "Resources", "download", filename),
        os.path.join(os.path.dirname(__file__), filename),
        os.path.join(os.path.dirname(__file__), "..", "Resources", "download", filename)
    ]
    
    for path in search_paths:
        if os.path.exists(path):
            return path
    raise FileNotFoundError(f"Could not find {filename} in any of: {search_paths}")

def compare_job_title_files(original_filename, updated_filename):
    """
    Compare two JSON files containing job titles data
    Returns: tuple of (added_items, modified_items, removed_items)
    """
    # Get full paths
    original_path = get_valid_path(original_filename)
    updated_path = get_valid_path(updated_filename)
    
    print(f"Using original file: {original_path}")
    print(f"Using updated file: {updated_path}")
    
    # Load JSON files
    with open(original_path, 'r', encoding='utf-8') as f:
        original = json.load(f)
    with open(updated_path, 'r', encoding='utf-8') as f:
        updated = json.load(f)
    
    # Convert to dictionaries with Job Title as key
    original_dict = {item['Job Title']: item for item in original}
    updated_dict = {item['Job Title']: item for item in updated}
    
    # Find differences
    added = [updated_dict[title] for title in updated_dict if title not in original_dict]
    removed = [original_dict[title] for title in original_dict if title not in updated_dict]
    
    # Find modified items
    modified = []
    common_titles = set(original_dict) & set(updated_dict)
    for title in common_titles:
        diff = DeepDiff(original_dict[title], updated_dict[title], 
                       ignore_order=True,
                       exclude_paths=["root['actions']"])
        if diff:
            modified.append({
                'job_title': title,
                'changes': diff,
                'original': original_dict[title],
                'updated': updated_dict[title]
            })
    
    return added, modified, removed

def generate_diff_report(added, modified, removed):
    """Generate a human-readable difference report"""
    report = []
    
    if added:
        report.append("\n=== ADDED JOB TITLES ===")
        for item in added:
            report.append(f" - {item['Job Title']} (Description: {item.get('Job Description', '')})")
    
    if removed:
        report.append("\n=== REMOVED JOB TITLES ===")
        for item in removed:
            report.append(f" - {item['Job Title']}")
    
    if modified:
        report.append("\n=== MODIFIED JOB TITLES ===")
        for change in modified:
            report.append(f" - {change['job_title']}:")
            for change_type, details in change['changes'].items():
                report.append(f"   {change_type.upper()}:")
                if isinstance(details, dict):
                    for k, v in details.items():
                        report.append(f"     - {k}: {v}")
                else:
                    report.append(f"     - {details}")
    
    return '\n'.join(report) if report else "No differences found"

if __name__ == "__main__":
    try:
        original_file = "original_job_titles.json"
        updated_file = "updated_job_titles.json"
        
        added, modified, removed = compare_job_title_files(original_file, updated_file)
        report = generate_diff_report(added, modified, removed)
        
        print("=== JSON COMPARISON REPORT ===")
        print(report)
        
        # Save report
        report_path = os.path.join(os.getcwd(), "comparison_report.txt")
        with open(report_path, 'w', encoding='utf-8') as f:
            f.write(report)
        print(f"\nReport saved to: {report_path}")
        
    except Exception as e:
        print(f"\nERROR: {str(e)}")
        print("\nTroubleshooting tips:")
        print("1. Verify your JSON files exist in either:")
        print("   - The same directory as this script")
        print("   - Resources/download/ directory")
        print("2. Check filenames are correct")
        print("3. Ensure files have valid JSON content")